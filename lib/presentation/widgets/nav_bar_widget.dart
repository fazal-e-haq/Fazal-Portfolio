import 'package:fazal_portfolio/models/nav_bar_item_model.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';

// NavBar
class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});
  // List of items which include in NavBar
  static const List<NavBarItem> items = [
    NavBarItem(title: 'Home', index: 0, icon: Icons.home),
    NavBarItem(title: 'About', index: 1, icon: Icons.info),
    NavBarItem(title: 'Projects', index: 2, icon: Icons.work),
    NavBarItem(title: 'Contact', index: 3, icon: Icons.mail),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 120,
            title: Container(
              height: 80,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Monomorphic design for the menu bar
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(100),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.03),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(-4, -4),
                  ),
                ],

                shape: BoxShape.rectangle,
              ),
              // Horizontal list of buttons for the menu
              child: Selector<NavigationProvider, int>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      return NavBarButton(
                        title: item.title,
                        icon: item.icon,
                        pageIndex: item.index,

                        isSelected: value == item.index,
                      );
                    }),
                  );
                },
                selector: (_, p) => p.currentIndex,
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

// NavBar button
class NavBarButton extends StatelessWidget {
  // Constructor
  const NavBarButton({
    super.key,
    this.title,
    required this.pageIndex,
    required this.icon,
    this.isSelected = false,
  });
  // Global variables
  final String? title;
  final int pageIndex;
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      // Use the provider's scroll method instead of local logic
      onPressed: () =>
          context.read<NavigationProvider>().scrollToSection(pageIndex),
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
      color: isSelected
          ? Colors.white.withValues(alpha: 0.3)
          : Theme.of(context).cardColor,
      icon: Icon(icon),
      text: Text(title!),
    );
  }
}
