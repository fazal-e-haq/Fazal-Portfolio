import 'package:fazal_portfolio/presentation/Pages/computer/computer_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/mobile_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/tab/tab_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  // This widget is the root of Website.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          if (maxWidth <= 500) {
            return MobileHomePage();
          }
          if (maxWidth <= 1000) {
            return TabHomePage();
          } else {
            return ComputerHomePage();
          }
        },
      ),
    );
  }
}
