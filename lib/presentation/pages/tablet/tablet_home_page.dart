import 'package:fazal_portfolio/presentation/Pages/tablet/about_section.dart';
import 'package:fazal_portfolio/presentation/Pages/tablet/contact_section.dart';
import 'package:fazal_portfolio/presentation/Pages/tablet/home_section.dart';
import 'package:fazal_portfolio/presentation/Pages/tablet/project_section.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This is the main page for tablet users
// Refactored to StatelessWidget using NavigationProvider for state management
class TabletHomePage extends StatelessWidget {
  const TabletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Access the navigation provider for section control
    final navProvider = context.read<NavigationProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // The top navigation bar
      appBar: preferredSizeAppBar(size, context, navProvider),
      body: Padding(
        padding: const EdgeInsets.only(top: 125),
        // PageView allows us to swipe between different sections horizontally
        child: PageView(
          controller: navProvider.pageController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(), // Allows smooth manual swiping too
          children: const [
            TabletHomeSection(),
            TabletAboutSection(),
            TabletProjectSection(),
            TabletContactSection(),
          ],
        ),
      ),
    );
  }

  // This creates the Navigation Bar (Menu) at the top
  PreferredSize preferredSizeAppBar(Size size, BuildContext context, NavigationProvider navProvider) {
    return PreferredSize(
      preferredSize: const Size(
        double.infinity,
        120,
      ),
      child: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 120,
        title: Container(
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // Neumorphic design for the menu bar
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 15,
                offset: const Offset(8, 8),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(-8, -8),
              ),
            ],
          ),
          // Horizontal list of buttons for the menu
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appBarButton('Home', 0, navProvider),
                const SizedBox(width: 8),
                appBarButton('About', 1, navProvider),
                const SizedBox(width: 8),
                appBarButton('Projects', 2, navProvider),
                const SizedBox(width: 8),
                appBarButton('Contact', 3, navProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A helper function to create each menu button
  Widget appBarButton(String title, int pageIndex, NavigationProvider navProvider) {
    return ButtonWidget(
      // Use the provider's scroll method
      onPressed: () => navProvider.scrollToSection(pageIndex),
      backgroundColor: const Color(0xFF001F9F),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      child: Text(title),
    );
  }
}
