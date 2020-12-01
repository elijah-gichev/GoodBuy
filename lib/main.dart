import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/about.dart';
import 'pages/QR_scanner.dart';

//В ФАЙЛЕ build.gradle изменена минимальная версия sdk с 16 на 24(андроид 7)
//из-за сканера

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffE5E5E5),
        primaryColor: Color(0xffE5E5E5), //#E5E5E5
      ),
      title: "It's First page",
      //home: QRScanner(),
      home: FirstPage(),
      //home: FirstPage(),
    );
  }
}
