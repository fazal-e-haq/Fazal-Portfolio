import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/themes/theme.dart';
import '../introduction/introduction_section.dart';
import '../about/about_section.dart';
import '../project/projects_section.dart';
import '../contact/contact_section.dart';
import '../../widgets/animations/scroll_3d_section.dart';
import '../../widgets/nav_bar_widget.dart';
import '../../widgets/bottom_nav_bar_widget.dart';
import 'scroll_coordinator_controller.dart';

/// Main single-page scrollable portfolio shell.
///
/// Coordinates smooth scrolling across all 4 sections ([Introduction], [AboutSection],
/// [ProjectsSection], and [ContactSection]) using [ScrollCoordinatorController] (GetX)
/// and wraps each section in a [Scroll3DSection] ([SketchScrollSection]) for a smooth,
/// flat sketchbook page reveal.
class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  late final ScrollCoordinatorController _scrollCoordinator;

  /// Global keys registered with [ScrollCoordinatorController] for navbar navigation
  /// and active section detection.
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  void initState() {
    super.initState();
    _scrollCoordinator = Get.put(ScrollCoordinatorController());
    _scrollCoordinator.registerKeys(_sectionKeys);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Warm up the image cache so hero image and logo load instantly without hitching
    precacheImage(
      const AssetImage('assets/Images/my-image/my-pic.webp'),
      context,
    );
    precacheImage(
      const AssetImage('assets/Images/brand/fazal-logo.webp'),
      context,
    );
    precacheImage(
      const AssetImage('assets/Images/works/cutcount/cutcount-logo.webp'),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final double screenHeight = MediaQuery.of(context).size.height;

        // Responsive breathing space between portfolio sections
        final double sectionGap = isMobile
            ? (screenHeight * 0.12).clamp(70.0, 120.0)
            : (screenHeight * 0.14).clamp(90.0, 140.0);
        final double introToAboutGap = isMobile ? 12.0 : 20.0;

        return Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: (!isMobile) ? const NavBarWidget() : null,
          bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollCoordinator.scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  KeyedSubtree(
                    key: _sectionKeys[0],
                    child: Introduction(
                      scrollController: _scrollCoordinator.scrollController,
                    ),
                  ),
                  SizedBox(height: introToAboutGap),
                  KeyedSubtree(
                    key: _sectionKeys[1],
                    child: Scroll3DSection(
                      scrollController: _scrollCoordinator.scrollController,
                      diagonalDirection: 1,
                      padding: EdgeInsets.only(
                        top: isMobile ? 12.0 : 20.0,
                        bottom: isMobile ? 36.0 : 48.0,
                      ),
                      child: const AboutSection(),
                    ),
                  ),
                  SizedBox(height: sectionGap),
                  KeyedSubtree(
                    key: _sectionKeys[2],
                    child: Scroll3DSection(
                      scrollController: _scrollCoordinator.scrollController,
                      diagonalDirection: -1,
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: ProjectsSection(
                        scrollController: _scrollCoordinator.scrollController,
                      ),
                    ),
                  ),
                  SizedBox(height: sectionGap),
                  KeyedSubtree(
                    key: _sectionKeys[3],
                    child: Scroll3DSection(
                      scrollController: _scrollCoordinator.scrollController,
                      diagonalDirection: 1,
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: const ContactSection(),
                    ),
                  ),
                  if (isMobile) const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
