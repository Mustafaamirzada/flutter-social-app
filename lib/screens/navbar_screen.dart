// ignore_for_file: prefer_final_fields, use_build_context_synchronously
import 'package:fchat/screens/home_screen.dart';
import 'package:fchat/screens/search_screen.dart';
import 'package:flutter/material.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    Scaffold(),
    CircularProgressIndicator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_sharp),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
        
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        unselectedLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}