import 'package:dating_app/pages/favorites_page.dart';
import 'package:dating_app/pages/main_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appTitle = 'Dating App';
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentTab = [
      MainPage(),
      FavoritesPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_appTitle),
      ),
      body: Center(
        child: currentTab.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
