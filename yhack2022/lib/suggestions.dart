import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class suggestions extends StatefulWidget {
  const suggestions({Key? key}) : super(key: key);

  @override
  State<suggestions> createState() => _suggestionsState();
}

class _suggestionsState extends State<suggestions> {
  @override
  int _currentRoute = 0;

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: Text("Sort"),
                  leading: GestureDetector(
                    onTap: (){},
                    child: Icon(Icons.sort),
                  ),
                ),
                body: ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("textfield 1: input date"),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                          Text("textfield 2: input content"),
                          Text("textfield 3: input SNS type"),
                          Text("textfield 4: input type of content: Post or Comment"),
                          Text("textfield 5: input danger_filter")
                        ])),
                    GestureDetector(
                      onTap:(){

                      }
                    ),
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Text("textfield 1"),
                          Text("textfield 2"),
                          Text("textfield 3")
                        ])),
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Text("textfield 1"),
                          Text("textfield 2"),
                          Text("textfield 3")
                        ])),
                  ],
                ),
                backgroundColor: Colors.white,
              );
            });
      },
    );
  }
}
