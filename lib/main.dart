import 'package:flutter/material.dart';

import 'pages/welcome.dart';
import 'pages/not_found.dart';
import 'pages/about.dart';
import 'pages/scanner_page.dart';
import 'pages/history.dart';

import 'package:page_transition/page_transition.dart';

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
        //'/about': (context) => About(),
        //'/not_found': (context) => NotFound(),
        '/scanner_page': (context) => ScannerPage(),
        //'/history': (context) => HistoryPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/about':
            return PageTransition(
              child: About(),
              type: PageTransitionType.rotate,
              duration: Duration(seconds: 1),
            );
            break;
          case '/history':
            return PageTransition(
              child: HistoryPage(),
              type: PageTransitionType.rotate,
              duration: Duration(milliseconds: 500),
            );
            break;
          case '/not_found':
            return PageTransition(
              child: NotFound(),
              type: PageTransitionType.rotate,
              duration: Duration(milliseconds: 500),
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}

class RotationRoute extends PageRouteBuilder {
  final Widget page;
  RotationRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
            ),
            child: child,
          ),
        );
}
