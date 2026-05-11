import 'package:fazal_portfolio/presentation/Pages/mobile/about_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/contact_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/home_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/project_section.dart';
import 'package:fazal_portfolio/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This is the main page for mobile users
// Refactored to StatelessWidget using NavigationProvider
class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the navigation provider
    final navProvider = context.read<NavigationProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: PageView(
          controller: navProvider.pageController,
          scrollDirection: Axis.vertical, // Vertical scrolling for mobile
          children: const [
            MobileHomeSection(),
            MobileAboutSection(),
            MobileProjectSection(),
            MobileContactSection(),
          ],
        ),
      ),
    );
  }
}
