import 'package:flutter/material.dart';

class NavBarItem {
  final String title;
  final int index;
  final IconData icon;

  const NavBarItem({
    required this.title,
    required this.index,
    required this.icon,
  });
}
