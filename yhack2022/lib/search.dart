import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  int _currentRoute = 0;

  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings, builder: (BuildContext context) {
        return Scaffold(
          appBar: (AppBar(title: Text("welcome to test page2"))),
          body: Text("hi!"),
          backgroundColor: Colors.white,);
      });
    },);
  }
}