import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

main() async {
  final response =
    await http.Client().get(Uri.parse('https://github.com/JonathanMonga'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      print(document.getElementsByTagName("p").length);
    } else {
      throw Exception();
    }
}