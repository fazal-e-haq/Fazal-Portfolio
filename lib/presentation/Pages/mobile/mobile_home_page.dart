import 'package:fazal_portfolio/presentation/Pages/mobile/about_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/contact_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/home_section.dart';
import 'package:fazal_portfolio/presentation/Pages/mobile/project_section.dart';
import 'package:flutter/material.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
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
