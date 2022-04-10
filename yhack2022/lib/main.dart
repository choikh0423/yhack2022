import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'suggestions.dart';
import 'search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: homepage());
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  int _selectedIndex = 0;

  static const List<Widget> _appBarTitle = <Widget>[
    Text('Suggestions', style: (TextStyle(color: Colors.black))),
    Text('Search', style: (TextStyle(color: Colors.black)))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.passiveColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: _appBarTitle[_selectedIndex],
              )
            ],
          )),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          suggestions(
            danger: <String>[],
            layered: false,
          ),
          search(
            danger: <String>[],
            layered: false,
          )
        ],
      ),
      bottomNavigationBar: Container(
        //decoration
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Palette.passiveColor,
          fixedColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: Palette.activeColor,
                icon: Icon(Icons.lightbulb),
                label: "suggestions"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
