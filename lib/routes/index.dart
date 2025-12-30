import 'package:flutter/material.dart';
import 'package:flutter_web/pages/Login/index.dart';
import 'package:flutter_web/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    initialRoute: '/',
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),
  };
}