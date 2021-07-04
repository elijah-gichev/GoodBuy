import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/welcome.dart';
import 'pages/favourite.dart';
import 'pages/about.dart';
import 'pages/scanner_page.dart';
import 'pages/history.dart';

import 'pages/add_review.dart';

import 'package:page_transition/page_transition.dart';
import 'package:bloc/bloc.dart';

import 'bloc/about/about_bloc.dart';
import 'cubit/timer/timer_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.orangeAccent[400],
          accentColorBrightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColor: Color(0xffE5E5E5), //#E5E5E5
        ),
        title: "GoodBuy",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return PageTransitionWrapper(child: ScannerPage());
              break;
            case '/logo':
              //не нужен красивый Transition
              return MaterialPageRoute(builder: (context) => FirstPage());
              break;
            case '/add_review':
              //не нужен красивый Transition
              return MaterialPageRoute(builder: (context) => AddReview());
              break;
            case '/about':
              return PageTransitionWrapper(
                child: About(),
                settings: settings,
              );
              break;
            case '/history':
              return PageTransitionWrapper(
                child: HistoryPage(),
              );
              break;
            case '/favourite':
              return PageTransitionWrapper(
                child: FavouritePage(),
              );
              break;
            default:
              throw UnimplementedError();
          }
        },
      ),
    );
  }
}

class PageTransitionWrapper extends PageTransition {
  PageTransitionWrapper({
    @required Widget child,
    PageTransitionType type = PageTransitionType.leftToRight,
    int durationAmount = 500,
    RouteSettings settings,
  }) : super(
          child: child,
          type: type,
          duration: Duration(milliseconds: durationAmount),
          settings: settings,
        );
}
