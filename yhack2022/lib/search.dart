import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Colors.black,),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,color: Colors.black,),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  int _currentRoute = 0;

  Widget build(BuildContext context) {
    bool? checked = false;
    bool? checked2 = false;
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: GestureDetector(
                      onTap: () {
                        _link(context, ".com");
                      },
                      child: Icon(Icons.refresh,color: Colors.black,),
                    ),
                    actions: <Widget>[
                      IconButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SearchPage())),
                          icon: Icon(Icons.search,color: Colors.black,)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {
                            _Filter(context,checked,checked2);
                          },
                          child: Icon(Icons.account_tree_outlined,color: Colors.black,)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {}, child: Icon(Icons.arrow_upward_sharp,color: Colors.black,)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.arrow_downward_sharp,color: Colors.black,)),
                      SizedBox(width: 10.0),
                    ]),
                body: ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("textfield 1: input date"),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                      )
                                    ],
                                  ),
                                  Text("textfield 2: input content"),
                                  Text("textfield 3: input SNS type"),
                                  Text(
                                      "textfield 4: input type of content: Post or Comment"),
                                  Text("textfield 5: input danger_filter"),
                                ])),
                        onTap: () {
                          _link(context, ".com");
                        }),
                    GestureDetector(
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("textfield 1: input date"),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                      )
                                    ],
                                  ),
                                  Text("textfield 2: input content"),
                                  Text("textfield 3: input SNS type"),
                                  Text(
                                      "textfield 4: input type of content: Post or Comment"),
                                  Text("textfield 5: input danger_filter"),
                                ])),
                        onTap: () {
                          _link(context, ".com");
                        }),
                  ],
                ),
                backgroundColor: Colors.white,
              );
            });
      },
    );
  }

  void _link(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Redirecting to your post"),
          content: new Text("$url"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _Filter(BuildContext context, bool? checked, bool? checked2) {

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Filters"),
              actions: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                        Text('Personal Information'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                        Text('Profanity'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checked2,
                          onChanged: (value) {
                            setState(() {
                              checked2 = value;
                            });
                          },
                        ),
                        Text('Danger-filter'),
                      ],
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Submit"),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
