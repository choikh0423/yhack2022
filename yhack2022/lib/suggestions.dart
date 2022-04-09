import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
                appBar: AppBar(
                  title: Text("Sort"),
                  leading: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.sort),
                  ),
                ),
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
        .where('danger', arrayContainsAny: ['Profanity'])
        .where('type', isEqualTo: "Post")
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
