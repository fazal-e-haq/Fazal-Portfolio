import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/button_widget.dart';
import '../nav_bar_item_model.dart';
import '../navigation_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

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
        // Mobile only
        if (constraints.maxWidth >= 600) {
          return const SizedBox.shrink();
        }

        return BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          height: 90,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            ),
            child: Selector<NavigationProvider, int>(
              selector: (_, provider) => provider.currentIndex,
              builder: (context, currentIndex, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: items.map((item) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: BottomNavBarButton(
                          title: item.title,
                          icon: item.icon,
                          pageIndex: item.index,
                          isSelected: currentIndex == item.index,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class BottomNavBarButton extends StatelessWidget {
  const BottomNavBarButton({
    super.key,
    required this.title,
    required this.pageIndex,
    required this.icon,
    this.isSelected = false,
  });

  final String title;
  final int pageIndex;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isVerySmallPhone = screenWidth < 400;

    return ButtonWidget(
      onPressed: () {
        context.read<NavigationProvider>().scrollToSection(pageIndex);
      },
      backgroundColor: const Color(0xFF001F9F),
      elevation: const WidgetStatePropertyAll(0),
      padding: EdgeInsets.symmetric(horizontal: isVerySmallPhone ? 4 : 8),
      color: isSelected
          ? Colors.white.withValues(alpha: 0.3)
          : Theme.of(context).cardColor,
      icon: Icon(icon, size: isVerySmallPhone ? 13 : 16),
      text: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontSize: isVerySmallPhone ? 10 : 12,
        ),
      ),
    );
  }
}
