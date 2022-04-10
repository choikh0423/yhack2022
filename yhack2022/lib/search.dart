import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final bool? checked = false;
final bool? checked2 = false;
final bool? checked3 = false;

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
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
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
  search({Key? key, required this.danger, required this.layered})
      : super(key: key);

  final List<String> danger;
  final bool layered;
  bool is_descending = false;

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  int _currentRoute = 0;

  appbarPresence(layered) {
    if (layered == false) {
      return AppBar(
          backgroundColor: Colors.white,
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
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {
                  _Filter(context, checked, checked2, checked3);
                },
                child: Icon(Icons.account_tree_outlined, color: Colors.black)),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _searchState();
                    widget.is_descending = true;
                  });
                },
                child: Icon(Icons.arrow_upward_sharp, color: Colors.black)),
            SizedBox(width: 10.0),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _searchState();
                    widget.is_descending = false;
                  });
                },
                child: Icon(Icons.arrow_downward_sharp, color: Colors.black)),
            SizedBox(width: 10.0),
          ]);
    } else {
      return AppBar(
        backgroundColor: Colors.white,
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
                  danger: widget.danger,
                  isDescending: widget.is_descending,
                ),
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
                        Text("Content: " +
                            snapshot.data!.docs[index]['content']),
                        Text("SNS: " + snapshot.data!.docs[index]['sns']),
                        Text("Type: " + snapshot.data!.docs[index]['type']),
                        Text("Danger Filter Detection: " +
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

void _Filter(
    BuildContext context, bool? checked, bool? checked2, bool? checked3) {
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
                      Text('Personal Information'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checked3,
                        onChanged: (value) {
                          setState(() {
                            checked3 = value;
                          });
                        },
                      ),
                      Text('Unstable Mood'),
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
                          if (checked3 == true) {
                            danger.add('Unstable Mood');
                          }
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => search(
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
