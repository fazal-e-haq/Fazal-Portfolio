import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as web;
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

  /// Completes once the HTML splash is removed AND the Flutter fade-in finishes.
  /// FadeInUpWidget awaits this so animations play visibly after the splash.
  static Completer<void> splashComplete = Completer<void>();

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

    // Reset for hot-restart support
    if (WebHomePage.splashComplete.isCompleted) {
      WebHomePage.splashComplete = Completer<void>();
    }

    // Fade-in controller: starts AFTER the HTML splash is removed
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // When the Flutter fade-in finishes, signal that entry animations can begin
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !WebHomePage.splashComplete.isCompleted) {
        WebHomePage.splashComplete.complete();
      }
    });

    // Listen for the HTML splash removal event from JavaScript.
    // Only THEN start the Flutter fade-in, so animations don't run behind the splash.
    _listenForSplashRemoval();
  }

  void _listenForSplashRemoval() {
    // Check if splash element is already gone (e.g. sessionStorage skip)
    final splash = web.document.getElementById('splash-container');
    if (splash == null) {
      // Splash already removed — start immediately
      _fadeController.forward();
      return;
    }

    // Wait for the JS 'splash-removed' custom event
    web.window.addEventListener(
      'splash-removed',
      (web.Event event) {
        if (mounted) _fadeController.forward();
      }.toJS,
    );
  }


  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The body that forces its children to rebuild and replay their internal entrance animations
    Widget bodyContent = Obx(() {
      final int index = _navController.currentIndex;
      return KeyedSubtree(
        key: ValueKey<int>(index),
        child: pages[index],
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

            // BODY: The content that rebuilds its state on tab change
            body: bodyContent,
          ),
        );
      },
    );
  }
}
