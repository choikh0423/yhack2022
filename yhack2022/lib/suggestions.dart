import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Palette.dart';

final bool? checked = false;
final bool? checked2 = false;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.activeColor,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
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

class suggestions extends StatefulWidget {
  suggestions({Key? key, required this.danger, required this.layered})
      : super(key: key);

  final List<String> danger;
  final bool layered;
  bool is_descending = false;

  @override
  State<suggestions> createState() => _suggestionsState();
}

class _suggestionsState extends State<suggestions> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  int _currentRoute = 0;

  appbarPresence(layered) {
    if (layered == false) {
      return AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(Icons.refresh, color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search, color: Colors.black)),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {
                  _Filter(context, checked, checked2);
                },
                child: Icon(Icons.account_tree_outlined, color: Colors.black)),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {},
                child: Icon(Icons.arrow_upward_sharp, color: Colors.black)),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {},
                child: Icon(Icons.arrow_downward_sharp, color: Colors.black)),
            SizedBox(width: 10.0),
          ]);
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: appbarPresence(widget.layered),
                body: ContentList(
                    danger: widget.danger, isDescending: widget.is_descending),
                backgroundColor: Colors.white,
              );
            });
      },
    );
  }
}

class ContentList extends StatefulWidget {
  ContentList({Key? key, required this.danger, required this.isDescending})
      : super(key: key);

  final List<String> danger;
  final bool isDescending;

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  Future<QuerySnapshot> get_documents() async {
    print(widget.danger);
    if (widget.danger.length == 0) {
      return await FirebaseFirestore.instance
          .collection('content')
          .orderBy('date_created', descending: widget.isDescending)
          .get();
    } else {
      return await FirebaseFirestore.instance
          .collection('content')
          .where('danger', arrayContainsAny: widget.danger)
          .get();
    }
  }

  array_to_string(arr) {
    String str = "";
    for (String word in arr) {
      str = str + " " + word + ",";
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get_documents(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _link(context, snapshot.data!.docs[index]['url']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(snapshot.data!.docs[index]['date_created']),
                            Spacer(),
                            Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ],
                        ),
                        Text("textfield 2: " +
                            snapshot.data!.docs[index]['content']),
                        Text("textfield 3: " +
                            snapshot.data!.docs[index]['sns']),
                        Text("textfield 4: " +
                            snapshot.data!.docs[index]['type']),
                        Text("textfield 5: input_danger_filter: " +
                            array_to_string(
                                snapshot.data!.docs[index]['danger'])),
                      ]),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Text("No data");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
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
              _launchURL(url);
            },
          ),
        ],
      );
    },
  );
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

void _Filter(BuildContext context, bool? checked, bool? checked2) {
  final List<String> danger = [];
  final bool layered = true;
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
                          print(checked2);
                        },
                      ),
                      Text('Personal Information'),
                    ],
                  ),
                  Row(
                    children: [
                      FlatButton(
                        onPressed: () {
                          if (checked == true) {
                            danger.add('Profanity');
                          }
                          if (checked2 == true) {
                            danger.add('Personal Information');
                          }
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => suggestions(
                                      danger: danger, layered: layered)));
                        },
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
