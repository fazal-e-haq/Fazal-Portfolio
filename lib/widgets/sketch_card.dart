import 'package:flutter/material.dart';
import '../core/themes/theme.dart';

/// A card that looks like a pencil sketch or brutalist block
class SketchCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool isHovered;
  final Color backgroundColor;

  const SketchCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(24.0),
    this.isHovered = false,
    this.backgroundColor = AppColors.surface,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: AppColors.textMain,
          width: 2.5, // Thick sharp border
        ),
        boxShadow: AppColors.sketchShadows(
          isPressed: !isHovered, // When hovered, it pops out. When not, it rests. Wait, usually hovering makes it pop.
          distance: isHovered ? 12.0 : 6.0,
        ),
      ),
      // To shift the actual box up and left when it casts a larger shadow
      transform: Matrix4.translationValues(
        isHovered ? -3.0 : 0.0,
        isHovered ? -3.0 : 0.0,
        0.0,
      ),
      child: child,
    );
  }
}
