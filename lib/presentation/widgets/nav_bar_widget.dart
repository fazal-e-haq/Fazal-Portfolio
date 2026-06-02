import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';
import 'button_widget.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.read<NavigationProvider>();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return PreferredSize(
            preferredSize: const Size(double.infinity, 120),
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
        return SizedBox();
      },
    );
  }

  Widget appBarButton(
    String title,
    int pageIndex,
    NavigationProvider navProvider,
  ) {
    return ButtonWidget(
      // Use the provider's scroll method instead of local logic
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
