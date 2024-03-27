import 'package:flutter/material.dart';
import 'package:study_at/components/bottom_nav_bar.dart';
import 'package:study_at/debug_pages/database_add.dart';
import 'package:study_at/debug_pages/database_remove.dart';
import 'package:study_at/pages/account_page.dart';
import 'package:study_at/pages/discover_page.dart';
import 'package:study_at/pages/map.dart';
import 'package:study_at/pages/starred_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _navBarIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _navBarIndex = index;
    });
  }

  final List<Widget> _pages = [
    const MapPage(),
    const StarredPage(),
    const DiscoverPage(),
    const AccountPage(),
    const DatabaseAdd(),
    const DatabaseRemove(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavBar(onTabChange: (index) => navigateBottomBar(index)),

      // Debug menu - do not ship in final version
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  'Study@ DEBUG MENU',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                )),
            ListTile(
              title: const Text('Database - Add',
                  style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.add),
              iconColor: Colors.white,
              onTap: () {
                setState(() {
                  _navBarIndex = 4;
                });
              },
            ),
            ListTile(
              title: Text('Database - Remove',
                  style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.remove),
              iconColor: Colors.white,
              onTap: () {
                setState(() {
                  _navBarIndex = 5;
                });
              },
            ),
          ],
        ),
      ),
      body: _pages[_navBarIndex],
    );
  }
}
