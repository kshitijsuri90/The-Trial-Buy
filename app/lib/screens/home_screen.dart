import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/categories/categories.dart';
import 'package:flutter_myntra_clone/screens/home.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<String, Object> _getPage() {
    final List<Map<String, Object>> _pages = [
      {
        'page': Home(),
      },
      {
        'page': Categories(),
      },
      {
        'page': Text(''),
      },
      {
        'page': Text(''),
      },
      {
        'page': Text(''),
      }
    ];

    return _pages[_selectedPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black87,
        selectedItemColor: Color.fromRGBO(255, 63, 108, 1),
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(Icons.tv),
            title: Text('Studio'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(Icons.explore),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(Icons.person_outline),
            title: Text('Profile'),
          ),
        ],
      ),
      body: _getPage()['page'],
    );
  }
}
