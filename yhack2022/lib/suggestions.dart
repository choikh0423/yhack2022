import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
  const suggestions({Key? key}) : super(key: key);

  @override
  State<suggestions> createState() => _suggestionsState();
}

class _suggestionsState extends State<suggestions> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  int _currentRoute = 0;

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        _link(context, ".com");
                      },
                      child: Icon(Icons.refresh),
                    ),
                    actions: <Widget>[
                      IconButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SearchPage())),
                          icon: Icon(Icons.search)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {
                            _Filter(context);
                          },
                          child: Icon(Icons.account_tree_outlined)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {}, child: Icon(Icons.arrow_upward_sharp)),
                      SizedBox(width: 10.0),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.arrow_downward_sharp)),
                      SizedBox(width: 10.0),
                    ]),
                body: ContentList(),
                backgroundColor: Colors.white,
              );
            });
      },
    );
  }
}

class ContentList extends StatefulWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  Future<QuerySnapshot> get_documents() async {
    final list = [];
    return await FirebaseFirestore.instance
        .collection('content')
        .orderBy('date_created', descending: false)
        .get();
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
                // onTap: () {
                //   _link(context);
                // },
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
            },
          ),
        ],
      );
    },
  );
}

void _Filter(BuildContext context) {
  bool? checked = false;
  bool? checked2 = false;
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
