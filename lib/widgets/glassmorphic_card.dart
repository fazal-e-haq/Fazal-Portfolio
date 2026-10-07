import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/themes/theme.dart';

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isHovered;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(24.0),
    this.borderRadius = 24.0,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.textMain.withValues(alpha: 0.6), // Frosted glass look
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.textMain.withValues(alpha: 0.8), // Shiny edge
              width: 1.5,
            ),
            // 
          ),
          child: child,
        ),
      ),
    );
  }
}
