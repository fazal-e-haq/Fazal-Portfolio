
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../sections/about/about.dart';
import '../sections/contact/contact.dart';
import '../sections/introduction/home.dart';
import '../sections/project/projects.dart';
import 'navigation_provider.dart';
import 'widgets/bottom_nav_bar_widget.dart';
import 'widgets/nav_bar_widget.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: const NavBarWidget(),
        ),
        body: SingleChildScrollView(
          controller: nav.scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildSection(
                child: const HomeSection(),
                index: 0,
                key: nav.sectionKeys[0],
              ),
              _buildSection(
                child: const AboutSection(),
                index: 1,
                key: nav.sectionKeys[1],
              ),
              _buildSection(
                child: const ProjectsSection(),
                index: 2,
                key: nav.sectionKeys[2],
              ),
              _buildSection(
                child: const ContactSection(),
                index: 3,
                key: nav.sectionKeys[3],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBarWidget(),
      ),
    );
  }

  Widget _buildSection({
    required Widget child,
    required int index,
    required GlobalKey key,
  }) {
    return Builder(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        final bool isMobile = size.width < 600;
        final double appBarHeight = isMobile ? 0 : 120;
        final double bottomBarHeight = isMobile ? 90 : 0;
        final double targetHeight = size.height - appBarHeight - bottomBarHeight;
        final bool isHome = index == 0;

        return Container(
          key: key,
          width: double.infinity,
          height: isHome ? (targetHeight > 0 ? targetHeight : 600) : null,
          constraints: !isHome
              ? BoxConstraints(
                  minHeight: targetHeight > 0 ? targetHeight : 500,
                )
              : null,
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
