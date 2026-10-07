import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/nav_bar_item_model.dart';
import '../features/app_shell/navigation_controller.dart';
import '../features/app_shell/scroll_coordinator_controller.dart';

class NavBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavBarWidget({super.key});

  static const List<NavBarItem> items = [
    NavBarItem(title: 'Intro', index: 0, icon: CupertinoIcons.home),
    NavBarItem(title: 'About', index: 1, icon: CupertinoIcons.person_crop_circle),
    NavBarItem(title: 'Works', index: 2, icon: CupertinoIcons.briefcase),
    NavBarItem(title: 'Contact', index: 3, icon: CupertinoIcons.mail),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Scribble secondary border
            Positioned.fill(
              child: Transform.rotate(
                angle: 0.015,
                child: Container(
                  decoration: BoxDecoration(
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
              angle: -0.010,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: AppColors.textMain,
                    width: 2.0,
                  ),
                ),
                child: Transform.rotate(
                  angle: 0.010,
                  child: Obx(() {
                    final int value = Get.isRegistered<ScrollCoordinatorController>() 
                        ? Get.find<ScrollCoordinatorController>().activeSectionIndex.value 
                        : Get.find<NavigationController>().currentIndex;
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.title,
        verticalOffset: 32,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.textMain,
            width: 2,
          ),
        ),
        textStyle: const TextStyle(
          color: AppColors.textMain,
          fontSize: 14,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
          fontFamily: 'Patrick Hand',
        ),
        child: GestureDetector(
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
          child: AnimatedScale(
            scale: _isPressed ? 0.90 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle, // Keep it edgy for sketch
                border: Border.all(
                  color: widget.isSelected || _isHovered
                      ? AppColors.textMain
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Icon(
                widget.icon,
                color: AppColors.textMain,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
