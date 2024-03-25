import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";

class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        color: Colors.black,
        activeColor: Colors.black,
        tabActiveBorder: Border.all(color: Colors.black),
        tabBorderRadius: 50,
        tabMargin: EdgeInsets.all(1),
        haptic: true,
        iconSize: 20,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(icon: Icons.home, text: 'Home', gap: 3,),
          GButton(icon: Icons.stars, text: 'Starred', gap: 3),
          GButton(icon: Icons.emoji_events, text: 'Discover@', gap: 3),
          GButton(icon: Icons.account_circle, text: 'Account', gap: 3)
        ],
      ),
    );
  }
}
