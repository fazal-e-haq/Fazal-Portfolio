import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/nav_bar_item_model.dart';
import '../features/app_shell/navigation_controller.dart';
import '../features/app_shell/scroll_coordinator_controller.dart';
import 'sketch_painter.dart';
import '../services/analytics_service.dart';

class NavBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavBarWidget({super.key});

  static const List<NavBarItem> items = [
    NavBarItem(title: 'Intro', index: 0, icon: CupertinoIcons.home),
    NavBarItem(
      title: 'About',
      index: 1,
      icon: CupertinoIcons.person_crop_circle,
    ),
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
      toolbarHeight: 96,
      title: Container(
        height: 68,
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: CustomPaint(
          painter: SketchBorderPainter(
            color: AppColors.textMain,
            backgroundColor: AppColors.background.withValues(alpha: 0.95),
            strokeWidth: 2.2,
            borderRadius: 28.0,
            wobble: 1.9,
            seed: 23,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Obx(() {
              final int currentIndex =
                  Get.isRegistered<ScrollCoordinatorController>()
                  ? Get.find<ScrollCoordinatorController>()
                        .activeSectionIndex
                        .value
                  : (Get.isRegistered<NavigationController>()
                        ? Get.find<NavigationController>().currentIndex
                        : 0);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: NavBarButton(
                      title: item.title,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
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
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.title,
      preferBelow: true,
      verticalOffset: 28,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: SketchTooltipDecoration(
        backgroundColor: AppColors.background,
        borderColor: AppColors.textMain,
        strokeWidth: 1.9,
        borderRadius: 10.0,
        wobble: 1.5,
        seed: widget.pageIndex * 13 + 11,
      ),
      textStyle: const TextStyle(
        color: AppColors.textMain,
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.0,
        fontFamily: 'Patrick Hand',
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            AnalyticsService.logNavClick(widget.title, widget.pageIndex);
            if (Get.isRegistered<ScrollCoordinatorController>()) {
              Get.find<ScrollCoordinatorController>().scrollToSection(
                widget.pageIndex,
              );
            } else if (Get.isRegistered<NavigationController>()) {
              Get.find<NavigationController>().setIndex(widget.pageIndex);
            }
          },
          onTapCancel: () => setState(() => _isPressed = false),
          behavior: HitTestBehavior.opaque,
          child: AnimatedScale(
            scale: _isPressed ? 0.85 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            child: SizedBox(
              width: 48,
              height: 48,
              child: CustomPaint(
                painter: widget.isSelected
                    ? SketchBorderPainter(
                        color: AppColors.textMain,
                        strokeWidth: 1.9,
                        borderRadius: 12.0,
                        wobble: 1.5,
                        seed: widget.pageIndex * 9 + 5,
                      )
                    : null,
                child: Center(
                  child: Icon(widget.icon, size: 22, color: AppColors.textMain),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
