import 'package:flutter/material.dart';
import 'suggestions.dart';
import 'search.dart';

void main() => runApp(const MyApp());

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
    Text('Suggestions'),
    Text('Search')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        children: [suggestions(), search()],
      ),
      bottomNavigationBar: Container(
        //decoration
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb),
              label: "suggestions"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "search"
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
