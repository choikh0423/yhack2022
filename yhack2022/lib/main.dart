import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetContent(),
    );
  }
}

class AddContent extends StatelessWidget {
  const AddContent({Key? key}) : super(key: key);

  final String sns = "";
  final String type = "";
  final String url = "";
  final String content = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference contents =
        FirebaseFirestore.instance.collection('content');

    Future<void> addContent() {
      return contents
          .add({
            'Sns': sns,
            'Type': type,
            'Url': url,
            'Content': content,
          })
          .then((value) => print("Content Added"))
          .catchError((error) => print("Failed to add content: $error"));
    }

    return TextButton(onPressed: addContent, child: Text("Add Content"));
  }
}

class GetContent extends StatelessWidget {
  const GetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Demo')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('content').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Loading Data");
            return Column(children: <Widget>[
              Text(snapshot.data.documents[0]['contents']?),
            ]);
          }),
    );
  }
}
