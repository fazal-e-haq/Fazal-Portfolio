import 'package:fazal_portfolio/presentation/Pages/computer/computer_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/mobile_home_page.dart';
import 'package:fazal_portfolio/presentation/Pages/tablet/tablet_home_page.dart';
import 'package:flutter/material.dart';

// This widget decides which layout (Mobile, Tablet, or Computer) to show
class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // LayoutBuilder gives us the width of the screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          // If the screen is very small (like a phone), show the mobile layout
          if (maxWidth <= 500) {
            return const MobileHomePage();
          } 
          // If the screen is medium (like a tablet), show the tablet layout
          else if (maxWidth <= 1024) {
            return const TabletHomePage();
          } 
          // Otherwise, show the full computer/desktop layout
          else {
            return const ComputerHomePage();
          }
        },
      ),
    );
  }
}
