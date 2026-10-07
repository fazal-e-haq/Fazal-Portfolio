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
import '../../widgets/hud/spatial_hud_overlay.dart';
import '../scene_3d/widgets/spatial_backdrop_canvas.dart';
import '../scene_3d/widgets/perspective_card_wrapper.dart';
import 'scroll_coordinator_controller.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  /// Completes once the HTML splash is removed AND the Flutter fade-in finishes.
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
    
    // Register the unified vertical scroll coordinator
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

  Widget _buildPerspectiveSection(Widget child, int index, BoxConstraints constraints) {
    // Force height to exactly viewport height for perfect scroll math mapping
    return SizedBox(
      height: constraints.maxHeight,
      child: Obx(() {
        final double progress = _scrollCoordinator.scrollProgress.value;
        // Calculate depth distance from this section
        final double distanceFromActive = (progress - index);
        
        // When active (distance == 0), depth is 0. 
        // When scrolling away, push it back into 3D space slightly
        final double zDepth = (distanceFromActive.abs() * -100).clamp(-500.0, 0.0);
        final double tiltX = (distanceFromActive * 0.1).clamp(-0.2, 0.2);

        return PerspectiveCardWrapper(
          depthZ: zDepth,
          tiltX: tiltX,
          child: Opacity(
            opacity: (1.0 - distanceFromActive.abs() * 0.5).clamp(0.0, 1.0),
            child: child,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);

        return FadeTransition(
          opacity: CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeOut,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent, // Background handled by SpatialBackdropCanvas
            extendBodyBehindAppBar: true,
            extendBody: true,
            
            appBar: (!isMobile) ? const NavBarWidget() : null,
            bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,

            body: MouseRegion(
              onHover: (event) => _scrollCoordinator.updateMouseParallax(event.localPosition, MediaQuery.of(context).size),
              child: Stack(
                children: [
                  // 1. Deepest Layer: 3D Spatial Environment
                  const Positioned.fill(
                    child: SpatialBackdropCanvas(),
                  ),

                  // 2. Middle Layer: Continuous Vertical Scrolling Content
                  Positioned.fill(
                    child: ListView(
                      controller: _scrollCoordinator.scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildPerspectiveSection(const Introduction(), 0, constraints),
                        _buildPerspectiveSection(const AboutSection(), 1, constraints),
                        _buildPerspectiveSection(const ProjectsSection(), 2, constraints),
                        _buildPerspectiveSection(const ContactSection(), 3, constraints),
                        // Add some bottom padding for the mobile nav bar space
                        if (isMobile) const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // 3. Top Layer: Floating HUD (Hidden on mobile for space)
                  if (!isMobile)
                    const SpatialHudOverlay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
