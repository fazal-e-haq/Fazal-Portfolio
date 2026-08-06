import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/nav_bar_item_model.dart';
import '../features/app_shell/navigation_controller.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  static const List<NavBarItem> items = [
    NavBarItem(title: 'Intro', index: 0, icon: CupertinoIcons.home),
    NavBarItem(title: 'About', index: 1, icon: CupertinoIcons.person),
    NavBarItem(title: 'Works', index: 2, icon: CupertinoIcons.briefcase),
    NavBarItem(title: 'Contact', index: 3, icon: CupertinoIcons.mail),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF16181C), // Deep premium dark background
          borderRadius: BorderRadius.circular(24),
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
        child: Obx(() {
          final int currentIndex = Get.find<NavigationController>().currentIndex;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6), // Closer space between icons
                child: BottomNavBarButton(
                  pageIndex: item.index,
                  icon: item.icon,
                  isSelected: currentIndex == item.index,
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class BottomNavBarButton extends StatefulWidget {
  const BottomNavBarButton({
    super.key,
    required this.pageIndex,
    required this.icon,
    this.isSelected = false,
  });

  final int pageIndex;
  final IconData icon;
  final bool isSelected;

  @override
  State<BottomNavBarButton> createState() => _BottomNavBarButtonState();
}

class _BottomNavBarButtonState extends State<BottomNavBarButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        Get.find<NavigationController>().setIndex(widget.pageIndex);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.85 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(widget.isSelected ? 16 : 12),
          decoration: BoxDecoration(
            color: widget.isSelected 
                ? theme.primaryColor.withValues(alpha: 0.2) 
                : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isSelected 
                  ? theme.primaryColor.withValues(alpha: 0.6) 
                  : Colors.transparent,
              width: 1,
            ),
            boxShadow: widget.isSelected ? [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 2,
              )
            ] : [],
          ),
          child: Icon(
            widget.icon, 
            size: 22,
            color: widget.isSelected ? theme.primaryColor : Colors.white60,
          ),
        ),
      ),
    );
  }
}
