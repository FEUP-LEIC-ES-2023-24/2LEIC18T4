import 'package:flutter/material.dart';
import 'package:study_at/components/bottom_nav_bar.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      body: _pages[_navBarIndex],
    );
  }
}
