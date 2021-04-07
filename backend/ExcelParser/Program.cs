using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
using Google.Apis.Sheets.v4.Data;
using Google.Apis.Util.Store;

namespace ExcelParser
{
    class Program
    {
        static string[] Scopes = { SheetsService.Scope.SpreadsheetsReadonly };
        static string ApplicationName = "Google Spreadsheets wrapper";
        static void Main(string[] args)
        {
            UserCredential credential;

            using (var stream = new FileStream("credentials.json", FileMode.Open, FileAccess.Read))
            {
                // The file token.json stores the user's access and refresh tokens, and is created
                // automatically when the authorization flow completes for the first time.
                string credPath = "token.json";
                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "example@gmail.com",
                    CancellationToken.None,
                    new FileDataStore(credPath, true)).Result;
                //Console.WriteLine("Credential file saved to: " + credPath);
            }

            // Install the service with HttpClient and application names.
            var service = new SheetsService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });

            // Spreadsheet id. 
            // https://docs.google.com/spreadsheets/d/1diiQw8zre_XH5Dty_J-18qXE8BGxoj7ZqPKIPL4v4hA
            String spreadsheetId = "1diiQw8zre_XH5Dty_J-18qXE8BGxoj7ZqPKIPL4v4hA";
            // Columns. We are looking to get from A to C.
            String range = "A:C";
            SpreadsheetsResource.ValuesResource.GetRequest request =
                service.Spreadsheets.Values.Get(spreadsheetId, range);
            // response execution
            ValueRange response = request.Execute();
            // response holder.
            IList<IList<Object>> values = response.Values;

            // Set console output to UTF8 so I won't see gibberish instead of cyrillic.
            Console.OutputEncoding = Encoding.UTF8;

            if (values != null && values.Count > 0)
            {
                Console.WriteLine("var review = new Entry[] {");
                foreach (var row in values)
                {
                    // Print columns A and C, which correspond to indices 0 and 2.
                    // We also need to escape some characters in Name column.
                    Console.WriteLine($"new Entry {{ID = { row[1]}, Name = \"{row[0].ToString().Escape()}\", Link = \"{ row[2]}\"}},");
                }
                Console.WriteLine("};");
            }
            else
            {
                Console.WriteLine("No data found.");
            }
            Console.Read();
        }
    }

    public static class StringHelpers
    {
        private static Dictionary<string, string> escapeMapping = new Dictionary<string, string>()
        {
            {"\"", @"\\\"""},
            {"\\\\", @"\\"},
            {"\a", @"\a"},
            {"\b", @"\b"},
            {"\f", @"\f"},
            {"\n", @"\n"},
            {"\r", @"\r"},
            {"\t", @"\t"},
            {"\v", @"\v"},
            {"\0", @"\0"},
        };

        private static Regex escapeRegex = new Regex(string.Join("|", escapeMapping.Keys.ToArray()));

        public static string Escape(this string s)
        {
            return escapeRegex.Replace(s, EscapeMatchEval);
        }

        private static string EscapeMatchEval(Match m)
        {
            if (escapeMapping.ContainsKey(m.Value))
            {
                return escapeMapping[m.Value];
            }
            return escapeMapping[Regex.Escape(m.Value)];
        }
    }

}
