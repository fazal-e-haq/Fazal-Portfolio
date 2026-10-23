import 'package:flutter/material.dart';

/// Reusable scroll-driven section wrapper tailored for the **Pencil Sketch / Sketchbook** theme.
///
/// How it works:
/// - Instead of 3D diagonal tilting/skewing (which distorts flat hand-drawn pencil lines),
///   each section behaves like a flat sketchbook sheet:
///   1. **Entering from bottom**: Smoothly rises upward (`translateY`), scales gently (`0.96 -> 1.0`),
///      and fades in (`opacity: 0.0 -> 1.0`).
///   2. **Active viewing zone**: Remains 100% flat, level, and full-opacity (`scale: 1.0`, `opacity: 1.0`)
///      for effortless reading and interaction.
///   3. **Scrolled past at top**: Gently lifts and fades out once scrolled past the viewport.
/// - Caches [child] inside a [RepaintBoundary] so zero `CustomPainter` repaints or widget
///   rebuilds happen during scrolling.
class Scroll3DSection extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry padding;

  /// Retained for backward compatibility with existing section callers and widget tests.
  final int diagonalDirection;

  const Scroll3DSection({
    super.key,
    required this.child,
    this.scrollController,
    this.padding = EdgeInsets.zero,
    this.diagonalDirection = 1,
  });

  @override
  State<Scroll3DSection> createState() => _Scroll3DSectionState();
}

class _Scroll3DSectionState extends State<Scroll3DSection> {
  final GlobalKey _boxKey = GlobalKey();

  /// Computes a normalized distance (`-1.0` to `1.0`) from the active viewport zone.
  /// Returns `0.0` whenever the section is inside the comfortable reading zone.
  double _computeNormalizedDistance({
    required double boxTop,
    required double boxBottom,
    required double screenHeight,
    required ScrollController controller,
  }) {
    final double enterAnchor = screenHeight * 0.72;
    final double exitAnchor = screenHeight * 0.22;
    final double transitionSpan = screenHeight * 0.45;

    if (boxTop > enterAnchor) {
      // Section is entering from below the viewport
      return ((boxTop - enterAnchor) / transitionSpan).clamp(0.0, 1.0);
    } else if (boxBottom < exitAnchor) {
      // Section is exiting above the viewport
      return ((boxBottom - exitAnchor) / transitionSpan).clamp(-1.0, 0.0);
    }

    // If the user has scrolled to the very bottom of the page, keep the final section locked flat
    if (controller.position.hasContentDimensions &&
        controller.offset >= controller.position.maxScrollExtent - 24.0 &&
        boxTop <= screenHeight * 0.80) {
      return 0.0;
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController? controller = widget.scrollController;
    if (controller == null) {
      return Padding(padding: widget.padding, child: widget.child);
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, cachedChild) {
        double translateY = 0.0;
        double scale = 1.0;
        double opacity = 1.0;

        if (controller.hasClients) {
          final RenderObject? renderObj = _boxKey.currentContext
              ?.findRenderObject();
          if (renderObj is RenderBox && renderObj.hasSize) {
            final Size screenSize = MediaQuery.of(context).size;
            final double screenHeight = screenSize.height;
            final double screenWidth = screenSize.width;

            if (screenHeight > 0 && screenWidth > 0) {
              final Offset pos = renderObj.localToGlobal(Offset.zero);
              final double boxTop = pos.dy;
              final double boxBottom = boxTop + renderObj.size.height;

              final double norm = _computeNormalizedDistance(
                boxTop: boxTop,
                boxBottom: boxBottom,
                screenHeight: screenHeight,
                controller: controller,
              );

              // Smooth cubic ease (`3t^2 - 2t^3`)
              final double t = norm.abs().clamp(0.0, 1.0);
              final double curved = t * t * (3.0 - 2.0 * t);
              final double signedCurved = norm < 0 ? -curved : curved;

              final bool isMobile = screenWidth < 600;
              final double maxSlideY = isMobile ? 28.0 : 44.0;
              final double maxScaleDrop = isMobile ? 0.03 : 0.045;

              // Flat 2D sketchbook sheet motion (zero 3D tilt/skew)
              translateY = signedCurved * maxSlideY;
              scale = 1.0 - (curved * maxScaleDrop);
              opacity = (1.0 - (curved * 0.92)).clamp(0.0, 1.0);
            }
          }
        }

        return RepaintBoundary(
          key: _boxKey,
          child: Padding(
            padding: widget.padding,
            child: IgnorePointer(
              ignoring: opacity < 0.15,
              child: Opacity(
                opacity: opacity,
                child: Transform.translate(
                  offset: Offset(0.0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.center,
                    child: cachedChild,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: RepaintBoundary(child: widget.child),
    );
  }
}

/// Alias for semantic clarity in the Sketchbook theme.
typedef SketchScrollSection = Scroll3DSection;
