import 'package:flutter/material.dart';
import 'pages/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xffE5E5E5),
        primaryColor: Color(0xffE5E5E5), //#E5E5E5
      ),
      title: "It's First page",
      home: FirstPage(),
    );
  }
}
