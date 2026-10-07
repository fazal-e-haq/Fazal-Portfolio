import 'package:flutter/material.dart';
import '../core/themes/theme.dart';

/// A card that looks like a hand-drawn pencil sketch block
class SketchCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool isHovered;
  final Color? backgroundColor;

  const SketchCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(24.0),
    this.isHovered = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.surface;
    final shadowDist = isHovered ? 12.0 : 6.0;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. The messy pencil shadow
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            top: shadowDist,
            left: shadowDist,
            right: -shadowDist,
            bottom: -shadowDist,
            child: Transform.rotate(
              angle: 0.015,
              child: Container(
                decoration: BoxDecoration(
                  // Hand-drawn shadows are usually not perfectly solid black, use high opacity
                  color: AppColors.textMain.withValues(alpha: 0.85),
                  border: Border.all(color: AppColors.textMain, width: 1),
                ),
              ),
            ),
          ),

          // 2. A faint secondary scribble border for the "not straight" pencil feel
          Positioned.fill(
            child: Transform.rotate(
              angle: 0.012,
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

          // 3. The main white/yellowish box, slightly rotated in the opposite direction
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            top: isHovered ? -3 : 0,
            left: isHovered ? -3 : 0,
            right: isHovered ? 3 : 0,
            bottom: isHovered ? 3 : 0,
            child: Transform.rotate(
              angle: -0.008,
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(
                    color: AppColors.textMain,
                    width: 2.0,
                  ),
                ),
                child: Transform.rotate(
                  angle: 0.008, // Counter-rotate so text/content remains perfectly straight
                  child: Padding(
                    padding: padding,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
