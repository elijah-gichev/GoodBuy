import 'package:flutter/material.dart';

import 'pages/welcome.dart';
import 'pages/favourite.dart';
import 'pages/not_found.dart';
import 'pages/about.dart';
import 'pages/scanner_page.dart';
import 'pages/history.dart';

import 'funcs/parser/parserOtzovik.dart';
import 'repository/repository.dart';

import 'package:page_transition/page_transition.dart';
import 'package:bloc/bloc.dart';

import 'bloc/about/about_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

void main() async {
  // Repository rep = Repository();

  // await rep.getAllDataThatMeetsRequirements();
  // final response = await http.Client().get(Uri.parse(
  //     "https://otzovik.com/reviews/sir_slivochniy_s_beloy_plesenyu_dairyhorn_camembert"));

  // if (response.statusCode == 200) {
  //   var document = parse(response.body);
  //   var name = document
  //       .querySelector('.product-name [itemprop="name"]')
  //       .innerHtml; // Название товара

  //   var img = document
  //       .querySelector('.product-photo [itemprop="image"]')
  //       .attributes["src"];

  //   // var rating = document
  //   //     .querySelector('.recommend-ratio span')
  //   //     .innerHtml; // Рейтинг товара
  //   var rating = document
  //       .querySelector('.product-rating')
  //       .attributes['title']
  //       .replaceAll("Общий рейтинг: ", "");
  //   // Рейтинг товара
  //   print("rating: $rating");
  // }

  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

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
        '/logo': (context) =>
            FirstPage(), //используется для корневой домашней папки вместо параметра home
        //'/about': (context) => About(),
        //'/not_found': (context) => NotFound(),
        //'/': (context) => ScannerPage(),
        //'/history': (context) => HistoryPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/about':
            return PageTransition(
              child: About(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
              settings: settings,
            );
            break;
          case '/':
            return PageTransition(
              child: ScannerPage(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
            );
            break;
          case '/history':
            return PageTransition(
              child: HistoryPage(),
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 500),
            );
            break;
          case '/favourite':
            return PageTransition(
              child: FavouritePage(),
              type: PageTransitionType.leftToRight,
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
