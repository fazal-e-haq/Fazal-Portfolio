import 'package:fazal_portfolio/presentation/pages/sections/about_section.dart';
import 'package:fazal_portfolio/presentation/pages/sections/contact_section.dart';
import 'package:fazal_portfolio/presentation/pages/sections/home_section.dart';
import 'package:fazal_portfolio/presentation/pages/sections/projects_section.dart';
import 'package:fazal_portfolio/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

import '../widgets/nav_bar_widget.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: NavBarWidget(),
        ),
        body: PageView(
          controller: nav.pageController,
          onPageChanged: nav.updateIndexFromScroll,
          children: const [
            HomeSection(),
            AboutSection(),
            ProjectsSection(),
            ContactSection(),
          ],
        ),
        bottomNavigationBar: const BottomNavBarWidget(),
      ),
    );
  }
}
