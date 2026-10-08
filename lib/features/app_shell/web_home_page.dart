import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as web;

import '../../core/constants/app_sizes.dart';
import '../introduction/introduction_section.dart';
import '../about/about_section.dart';
import '../project/projects_section.dart';
import '../contact/contact_section.dart';
import '../../widgets/nav_bar_widget.dart';
import '../../widgets/bottom_nav_bar_widget.dart';
import '../scene_3d/widgets/spatial_backdrop_canvas.dart';
import 'scroll_coordinator_controller.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  static Completer<void> splashComplete = Completer<void>();

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final ScrollCoordinatorController _scrollCoordinator;

  @override
  void initState() {
    super.initState();
    
    _scrollCoordinator = Get.put(ScrollCoordinatorController());

    if (WebHomePage.splashComplete.isCompleted) {
      WebHomePage.splashComplete = Completer<void>();
    }

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !WebHomePage.splashComplete.isCompleted) {
        WebHomePage.splashComplete.complete();
      }
    });

    _listenForSplashRemoval();
  }

  void _listenForSplashRemoval() {
    final splash = web.document.getElementById('splash-container');
    if (splash == null) {
      _fadeController.forward();
      return;
    }

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);

        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            
            appBar: (!isMobile) ? const NavBarWidget() : null,
            bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,

            body: MouseRegion(
              onHover: (event) => _scrollCoordinator.updateMouseParallax(event.localPosition, MediaQuery.of(context).size),
              child: Stack(
                children: [
                  // 1. Deepest Layer: Sketch Background
                  const Positioned.fill(
                    child: SpatialBackdropCanvas(),
                  ),

                  // 2. Middle Layer: Smooth scrolling ListView
                  Positioned.fill(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: ListView(
                        controller: _scrollCoordinator.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          const Introduction(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 80.0), child: AboutSection()),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 80.0), child: ProjectsSection()),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 80.0), child: ContactSection()),
                          // Bottom padding for mobile
                          if (isMobile) const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),

                  // 3. Top Layer: Floating HUD
                  
                ],
              ),
          ),
        );
      },
    );
  }
}

