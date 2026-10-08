import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/themes/theme.dart';
import '../introduction/introduction_section.dart';
import '../about/about_section.dart';
import '../project/projects_section.dart';
import '../contact/contact_section.dart';
import '../../widgets/nav_bar_widget.dart';
import '../../widgets/bottom_nav_bar_widget.dart';
import 'scroll_coordinator_controller.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  late final ScrollCoordinatorController _scrollCoordinator;
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        return Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: (!isMobile) ? const NavBarWidget() : null,
          bottomNavigationBar: isMobile ? const BottomNavBarWidget() : null,
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollCoordinator.scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    key: _sectionKeys[0],
                    child: Introduction(scrollController: _scrollCoordinator.scrollController),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Container(
                    key: _sectionKeys[1],
                    padding: const EdgeInsets.symmetric(vertical: 80.0),
                    child: const AboutSection(),
                  ),
                  Container(
                    key: _sectionKeys[2],
                    padding: const EdgeInsets.symmetric(vertical: 80.0),
                    child: const ProjectsSection(),
                  ),
                  Container(
                    key: _sectionKeys[3],
                    padding: const EdgeInsets.symmetric(vertical: 80.0),
                    child: const ContactSection(),
                  ),
                  if (isMobile) const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
