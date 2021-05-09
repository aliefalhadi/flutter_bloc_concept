import 'package:bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:bloc_concept/presentation/views/home.dart';
import 'package:bloc_concept/presentation/views/home_second.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage(title: "HOME",));
        break;
      case '/second':
        return MaterialPageRoute(builder: (_) => MyHomePageSecond(title: "HOME Second"));
        break;
      default:
        return null;
    }
  }
}