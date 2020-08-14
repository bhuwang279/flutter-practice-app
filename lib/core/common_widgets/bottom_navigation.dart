import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        color: Color(0xFF17ead9),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
        }
    );
  }
}
