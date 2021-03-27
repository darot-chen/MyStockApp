import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'home.dart';
import 'report_screen.dart';
import 'sales_screen.dart';

class NavigationTabBar extends StatefulWidget {
  const NavigationTabBar({
    Key key,
  }) : super(key: key);

  @override
  _NavigationTabBarState createState() => _NavigationTabBarState();
}

class _NavigationTabBarState extends State<NavigationTabBar> {
  List<dynamic> _pages;
  @override
  void initState() {
    _pages = [
      Home(),
      SaleScreen(),
      ReportScreen(),
      AccountScreen(),
    ];
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_business,
            ),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.red.withOpacity(0.5),
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
