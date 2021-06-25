import 'package:flutter/material.dart';
import 'Controller.dart';
//source : https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
void main() {
  runApp(ItemDataApp());
}

class ItemDataApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemDataAppState();
}

class _ItemDataAppState extends State<ItemDataApp> {
  ControllerRouterDelegate _routerDelegate = ControllerRouterDelegate();
  ControllerRouteInformationParser _routeInformationParser =
  ControllerRouteInformationParser();

  @override
    Widget build(BuildContext context) {
      return MaterialApp.router(
        title: 'Elements App',
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      );
    }
  }

