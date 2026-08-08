import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/introduction/introduction_section.dart';
import 'package:fazal_portfolio/features/about/about_section.dart';
import 'package:fazal_portfolio/features/contact/contact_section.dart';
import 'package:fazal_portfolio/widgets/nav_bar_widget.dart';
import 'package:fazal_portfolio/widgets/bottom_nav_bar_widget.dart';
import 'package:fazal_portfolio/core/constants/app_sizes.dart';
import '../project/projects_section.dart';
import 'navigation_controller.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> with SingleTickerProviderStateMixin {
  late final NavigationController _navController;
  late final AnimationController _fadeController;

  static final List<Widget> pages = [
    const Introduction(),
    const AboutSection(),
    const ProjectsSection(),
    const ContactSection(),
  ];

  @override
  void initState() {
    super.initState();
    _navController = Get.find<NavigationController>();

    // Initial fade in animation when Flutter takes over from splash screen
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Smooth 1-second fade in
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The Body that will be shown across all screen sizes with Fade + SlideUp animation
    Widget animatedBody = Obx(() {
      final int currentIndex = _navController.currentIndex;
      
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05), // Starts slightly lower
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: SizedBox(
          key: ValueKey<int>(currentIndex),
          width: double.infinity,
          height: double.infinity,
          child: pages[currentIndex],
        ),
      );
    });

    // Provide the layout structure
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = AppSizes.isMobile(constraints);

        return FadeTransition(
          opacity: CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeOut,
          ),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            extendBodyBehindAppBar: true, // Appbar floats beautifully over content
            extendBody: true,             // Bottom navigation floats over content
            
            // TOP NAV BAR: Only show if Desktop, Tablet, or Ultrawide
            appBar: (!isMobile) ? const NavBarWidget() : null,

            // BOTTOM NAV BAR: Only show if Mobile
            bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,

            // BODY: The AnimatedSwitcher stays the same across all devices
            body: animatedBody,
          ),
        );
      },
    );
  }
}
