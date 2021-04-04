import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/not_found.dart';

import 'pages/about.dart';
import 'pages/QR_scanner.dart';

import 'screens/history_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.orangeAccent[400],
        accentColorBrightness: Brightness.light,
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffE5E5E5),
        primaryColor: Color(0xffE5E5E5), //#E5E5E5
      ),
      title: "GoodBuy",
      routes: {
        '/': (context) =>
            FirstPage(), //используется для корневой домашней папки вместо параметра home
        '/about': (context) => About('temp data'),
        '/not_found': (context) => NotFound(),
      },
    );
  }
}