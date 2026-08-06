import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../about_controller.dart';

class HoverInfoCard extends StatelessWidget {
  const HoverInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    required this.accentColor,
    required this.isMobile,
    required this.isTablet,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;
  final bool isMobile;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    final String hoverKey = 'info_card_$title';

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      cursor: SystemMouseCursors.click,
      child: Obx(() {
        final bool isHovered = controller.isHovered(hoverKey);
        
        return AnimatedSlide(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          offset: isHovered ? const Offset(0, -0.05) : Offset.zero,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            scale: isHovered ? 1.05 : 1.0, 
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isHovered ? accentColor.withValues(alpha: 0.1) : AppColors.surface,
                    AppColors.surfaceInner.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: isHovered 
                    ? AppColors.neumorphicShadows(distance: 20, blur: 40, glowColor: accentColor.withValues(alpha: 0.25)) 
                    : AppColors.neumorphicShadows(distance: 8, blur: 16),
                border: Border(
                  left: BorderSide(
                    color: isHovered ? accentColor : accentColor.withValues(alpha: 0.3),
                    width: 4.0,
                  ),
                  top: BorderSide(
                    color: isHovered ? accentColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.03),
                    width: isHovered ? 2.0 : 1.0,
                  ),
                  right: BorderSide(
                    color: isHovered ? accentColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.03),
                    width: isHovered ? 2.0 : 1.0,
                  ),
                  bottom: BorderSide(
                    color: isHovered ? accentColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.03),
                    width: isHovered ? 2.0 : 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isHovered 
                          ? accentColor.withValues(alpha: 0.3) 
                          : accentColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      boxShadow: isHovered 
                          ? [
                              BoxShadow(
                                color: accentColor.withValues(alpha: 0.6),
                                blurRadius: 20,
                                spreadRadius: 4,
                              )
                            ]
                          : [],
                    ),
                    child: Icon(icon, color: accentColor, size: 32),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Unbounded',
                      fontSize: isMobile ? 22 : (isTablet ? 18 : 22), 
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      height: 1.8,
                      fontSize: isMobile ? 14 : (isTablet ? 13 : 15), 
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
