import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/introduction/home.dart';
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

class _WebHomePageState extends State<WebHomePage> {
  final PageController _controller = PageController();
  late final NavigationController _navController;
  late final Worker _navWorker;

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

    // Listen to changes in currentIndex using ever worker
    _navWorker = ever(_navController.currentIndexRx, (int index) {
      if (_controller.hasClients && _controller.page?.round() != index) {
        _controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _navWorker.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The PageView that will be shown across all screen sizes
    Widget pageViewBody = PageView(
      controller: _controller,
      onPageChanged: (index) {
        // Sync manual swiping back to the Controller (so the Nav bar active state updates)
        if (_navController.currentIndex != index) {
          _navController.setIndex(index);
        }
      },
      children: pages,
    );

    // Provide the layout structure
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = AppSizes.isDesktop(constraints);
        bool isTablet = AppSizes.isTablet(constraints);
        bool isMobile = AppSizes.isMobile(constraints);

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // TOP NAV BAR: Only show if Desktop or Tablet
          appBar: (isDesktop || isTablet) ? const NavBarWidget() : null,

          // BOTTOM NAV BAR: Only show if Mobile
          bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,

          // BODY: The PageView stays the same across all devices
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.getHorizontalPadding(constraints),
              vertical: AppSizes.getVerticalPadding(constraints),
            ),
            child: pageViewBody,
          ),
        );
      },
    );
  }
}
