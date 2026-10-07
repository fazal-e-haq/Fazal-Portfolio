import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/nav_bar_item_model.dart';
import '../features/app_shell/navigation_controller.dart';
import '../features/app_shell/scroll_coordinator_controller.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  static const List<NavBarItem> items = [
    NavBarItem(title: 'Intro', index: 0, icon: CupertinoIcons.home),
    NavBarItem(title: 'About', index: 1, icon: CupertinoIcons.person_crop_circle),
    NavBarItem(title: 'Works', index: 2, icon: CupertinoIcons.briefcase),
    NavBarItem(title: 'Contact', index: 3, icon: CupertinoIcons.mail),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Scribble secondary border
                Positioned.fill(
                  child: Transform.rotate(
                    angle: 0.025,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: AppColors.textMain.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                // Main outline box
                Transform.rotate(
                  angle: -0.015,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Outline only!
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppColors.textMain,
                        width: 2.0,
                      ),
                    ),
                    child: Transform.rotate(
                      angle: 0.015,
                      child: Obx(() {
                        final int currentIndex = Get.isRegistered<ScrollCoordinatorController>()
                            ? Get.find<ScrollCoordinatorController>().activeSectionIndex.value
                            : Get.find<NavigationController>().currentIndex;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
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
                  ),
                ),
              ],
            ),
          ),
        ],
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
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (Get.isRegistered<ScrollCoordinatorController>()) {
          Get.find<ScrollCoordinatorController>().scrollToSection(widget.pageIndex);
        } else {
          Get.find<NavigationController>().setIndex(widget.pageIndex);
        }
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
            color: Colors.transparent,
            shape: BoxShape.rectangle, // Keep it edgy
            border: Border.all(
              color: widget.isSelected ? AppColors.textMain : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(
            widget.icon,
            size: 22,
            color: AppColors.textMain,
          ),
        ),
      ),
    );
  }
}
