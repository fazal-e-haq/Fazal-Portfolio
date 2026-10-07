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

  Widget _buildZAxisSection(Widget child, int index, BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight,
      width: constraints.maxWidth,
      child: Obx(() {
        final double progress = _scrollCoordinator.scrollProgress.value;
        final double distance = index - progress;
        
        double scale = 1.0;
        double opacity = 1.0;
        double translateY = 0.0;

        if (distance > 0) {
          // Approaching from distance (curves for smoother arrival)
          final curvedDist = Curves.easeOutCubic.transform((distance).clamp(0.0, 1.0));
          scale = 1.0 - (curvedDist * 0.35); // Shrinks softly
          opacity = 1.0 - (curvedDist * 0.6); // Fades softly
          translateY = curvedDist * constraints.maxHeight * 0.15;
        } else {
          // Flying past the camera (accelerates quickly)
          final curvedDist = Curves.easeInQuad.transform((distance.abs()).clamp(0.0, 1.0));
          scale = 1.0 + (curvedDist * 1.8); // Blows up massively
          opacity = 1.0 - (curvedDist * 1.0); // Fades out completely
          translateY = curvedDist * constraints.maxHeight * -0.1;
        }

        // Stick the item exactly to the viewport by counter-translating the scroll distance
        final double stickOffset = (progress - index) * constraints.maxHeight;

        if (opacity <= 0.0) return const SizedBox.shrink();

        return Transform.translate(
          offset: Offset(0, stickOffset + translateY),
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: child,
            ),
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

                  // 2. Middle Layer: The Z-Axis 3D ListView
                  Positioned.fill(
                    child: ListView(
                      controller: _scrollCoordinator.scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildZAxisSection(const Introduction(), 0, constraints),
                        _buildZAxisSection(const AboutSection(), 1, constraints),
                        _buildZAxisSection(const ProjectsSection(), 2, constraints),
                        _buildZAxisSection(const ContactSection(), 3, constraints),
                        // Bottom padding for mobile
                        if (isMobile) const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // 3. Top Layer: Floating HUD
                  if (!isMobile)
                    const SpatialHudOverlay(),
                ],
              ),
          ),
        );
      },
    );
  }
}
