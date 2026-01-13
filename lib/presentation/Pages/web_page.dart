import 'package:fazal_portfolio/presentation/Pages/computer/computer_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/mobile_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/tab/tab_home_page.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black87
              ,Colors.deepPurple,
            ],
            stops: [0.55, 0.55,],
          ),



        ),

        child: LayoutBuilder(
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
      ),
    );
  }
}
