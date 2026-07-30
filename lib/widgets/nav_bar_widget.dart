import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/navbar_model/nav_bar_item_model.dart';
import '../features/app_shell/navigation_controller.dart';

// NavBar
class NavBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavBarWidget({super.key});

  // List of items which include in NavBar using Premium Cupertino Icons
  static const List<NavBarItem> items = [
    NavBarItem(title: 'Intro', index: 0, icon: CupertinoIcons.home),
    NavBarItem(title: 'About', index: 1, icon: CupertinoIcons.person),
    NavBarItem(title: 'Projects', index: 2, icon: CupertinoIcons.briefcase),
    NavBarItem(title: 'Contact', index: 3, icon: CupertinoIcons.mail),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      forceMaterialTransparency: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 120,
      title: Container(
        height: 64,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        // Premium Monomorphic / Neumorphic design for the menu bar
        decoration: BoxDecoration(
          color: const Color(0xFF16181C), // Deep premium dark background
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        // Horizontal list of animated hover buttons
        child: Obx(() {
          final int value = Get.find<NavigationController>().currentIndex;
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
        }),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

// Animated NavBar button
class NavBarButton extends StatefulWidget {
  const NavBarButton({
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
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.title,
        verticalOffset: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF16181C), // Deep dark premium background
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          fontFamily: 'Unbounded',
        ),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            Get.find<NavigationController>().setIndex(widget.pageIndex);
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedScale(
            scale: _isPressed ? 0.90 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? theme.primaryColor.withValues(alpha: 0.15)
                    : (_isHovered
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.transparent),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.isSelected
                      ? theme.primaryColor.withValues(alpha: 0.5)
                      : Colors.transparent,
                  width: 1,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                widget.icon,
                color: widget.isSelected
                    ? theme.primaryColor
                    : (_isHovered ? Colors.white : Colors.white54),
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
