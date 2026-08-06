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
          width: double.infinity, // Full width
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(isHovered ? 16 : 24),
            border: Border.all(
              color: isHovered ? theme.primaryColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
              width: 1.5,
            ),
            boxShadow: isHovered 
                ? AppColors.neumorphicShadows(distance: 10, blur: 30, glowColor: theme.primaryColor.withValues(alpha: 0.1))
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isHovered ? theme.primaryColor.withValues(alpha: 0.15) : AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHovered ? theme.primaryColor : Colors.transparent,
                    width: 1,
                  ),
                  boxShadow: isHovered ? [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ] : AppColors.neumorphicShadows(distance: 4, blur: 10),
                ),
                child: AnimatedScale(
                  scale: isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    icon,
                    size: isMobile ? 24 : 32,
                    color: isHovered ? Colors.white : theme.primaryColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResponsiveText(
                      title,
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ResponsiveText(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: isMobile ? 13 : 14,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
