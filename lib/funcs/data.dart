// import 'package:html/parser.dart';
// import 'package:http/http.dart' as http;

// Future<String> getName() async{

//   String url = 'https://otzovik.com/reviews/sir_bondzhorno_rikotta_vanilnaya/';

//   final response = await http.Client().get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     var document = parse(response.body);

//     var elem = document.getElementsByClassName('product-name')[0].children[0];

//     //print(document.getElementsByTagName("p").length);
//     //var link = document.getElementsByClassName('vcard-names')[0].children[0];
//     //var text = link.text;

//     return elem.text;
//   } else {
//     return null;
//   }
// }
