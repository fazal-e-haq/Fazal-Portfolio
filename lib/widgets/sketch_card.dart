import 'package:flutter/material.dart';
import '../core/themes/theme.dart';
import 'sketch_painter.dart';

/// A card that looks like an authentic hand-drawn pencil sketch block (no straight lines).
/// Intelligently fits content size by default, or respects explicit constraints.
class SketchCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final bool isHovered;
  final bool enableHover;
  final Color? backgroundColor;
  final double borderRadius;
  final double wobble;
  final int seed;

  const SketchCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(24.0),
    this.isHovered = false,
    this.enableHover = true,
    this.backgroundColor,
    this.borderRadius = 18.0,
    this.wobble = 2.2,
    this.seed = 3,
  });

  @override
  State<SketchCard> createState() => _SketchCardState();
}

class _SketchCardState extends State<SketchCard> {
  bool _localHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool effectiveHover =
        widget.enableHover && (widget.isHovered || _localHovered);

    final Widget card = MouseRegion(
      onEnter: widget.enableHover
          ? (_) => setState(() => _localHovered = true)
          : null,
      onExit: widget.enableHover
          ? (_) => setState(() => _localHovered = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, effectiveHover ? -3.0 : 0.0, 0.0, 1.0),
        transformAlignment: Alignment.center,
        child: CustomPaint(
          painter: SketchBorderPainter(
            color: AppColors.textMain,
            backgroundColor: widget.backgroundColor,
            strokeWidth: 2.2,
            borderRadius: widget.borderRadius,
            wobble: widget.wobble,
            seed: widget.seed,
            isHovered: effectiveHover,
          ),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );

    if (widget.width != null || widget.height != null) {
      return SizedBox(width: widget.width, height: widget.height, child: card);
    }

    return card;
  }
}
