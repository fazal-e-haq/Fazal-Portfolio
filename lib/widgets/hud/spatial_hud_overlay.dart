import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/app_shell/scroll_coordinator_controller.dart';
import '../../core/themes/theme.dart';

/// Floating Spatial HUD (Heads-Up Display) navigation spine.
/// Shows vertical progression, active section milestone, and click-to-scroll waypoints.
class SpatialHudOverlay extends StatelessWidget {
  const SpatialHudOverlay({super.key});

  static const List<String> sections = ['INTRO', 'ABOUT', 'WORKS', 'CONTACT'];

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ScrollCoordinatorController>()) {
      return const SizedBox.shrink();
    }

    final scrollCoordinator = Get.find<ScrollCoordinatorController>();

    return Positioned(
      right: 28,
      top: 0,
      bottom: 0,
      child: Center(
        child: Obx(() {
          final int activeIndex = scrollCoordinator.activeSectionIndex.value;
          final double progress = scrollCoordinator.overallProgress.value;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.textMain.withValues(alpha: 0.06),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top progress track percentage
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),

                // Vertical timeline points
                ...List.generate(sections.length, (index) {
                  final bool isSelected = activeIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Tooltip(
                      message: sections[index],
                      preferBelow: false,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceInner,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.textMain.withValues(alpha: 0.10)),
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        color: AppColors.textMain,
                      ),
                      child: InkWell(
                        onTap: () => scrollCoordinator.scrollToSection(index),
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          width: isSelected ? 8 : 6,
                          height: isSelected ? 24 : 6,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.textMain.withValues(alpha: 0.24),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
