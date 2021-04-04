import 'package:flutter/material.dart';

import 'pages/welcome.dart';
import 'pages/not_found.dart';
import 'pages/about.dart';
import 'pages/scanner_page.dart';
import 'pages/history.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.orangeAccent[400],
        accentColorBrightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Color(0xffE5E5E5), //#E5E5E5
      ),
      title: "GoodBuy",
      routes: {
        '/': (context) =>
            FirstPage(), //используется для корневой домашней папки вместо параметра home
        '/about': (context) => About(),
        '/not_found': (context) => NotFound(),
        '/scanner_page': (context) => ScannerPage(),
        '/history': (context) => HistoryPage(),
      },
    );
  }
}
