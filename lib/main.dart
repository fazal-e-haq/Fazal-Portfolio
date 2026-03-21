
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/presentation/Pages/web_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  // This widget is the root of Website.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: mainTheme,  home: WebPage());
  }
}
