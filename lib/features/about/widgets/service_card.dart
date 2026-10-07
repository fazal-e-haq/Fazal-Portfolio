import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../about_controller.dart';

class ServiceCard extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isMobile;

  const ServiceCard({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    final String hoverKey = 'service_card_$index';
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: Obx(() {
        final bool isHovered = controller.isHovered(hoverKey);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, isHovered ? -8.0 : 0.0, 0),
          width: double.infinity, // Full width (constrained by parent)
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32), // More padding for modern feel
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered ? theme.primaryColor.withValues(alpha: 0.5) : AppColors.textMain.withValues(alpha: 0.05),
              width: 1.5,
            ),
            
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHovered ? theme.primaryColor : Colors.transparent,
                    width: 1,
                  ),

                ),
                child: AnimatedScale(
                  scale: isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    icon,
                    size: isMobile ? 24 : 32,
                    color: isHovered ? AppColors.textMain : theme.primaryColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Text Content
              ResponsiveText(
                title,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 12),
              ResponsiveText(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: isMobile ? 13 : 14,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
