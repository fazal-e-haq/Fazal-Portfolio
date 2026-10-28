import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A handcrafted pencil-sketch GitHub Contribution Heatmap backdrop (Full One Year / 52 Weeks).
/// Displays 52 columns x 7 rows of hand-drawn boxes with:
/// - Double-pencil wobbly outlines (matching buttons and navbar)
/// - Interactive hover bubble scale effect (smooth ripple scaling under cursor)
/// - Zero card border, zero text, zero dates, centered behind Fazal's portrait
class SketchGithubStatsBackground extends StatefulWidget {
  const SketchGithubStatsBackground({
    super.key,
    required this.width,
    this.height,
    this.isMobile = false,
  });

  final double width;
  final double? height;
  final bool isMobile;

  @override
  State<SketchGithubStatsBackground> createState() =>
      _SketchGithubStatsBackgroundState();
}

class _SketchGithubStatsBackgroundState
    extends State<SketchGithubStatsBackground> {
  Offset? _hoverPos;

  @override
  Widget build(BuildContext context) {
    // 52 weeks (one full year) x 7 days (Sun - Sat) = 364 boxes
    const int cols = 52;
    const int rows = 7;

    // Box dimensions: full year grid width ~1035px on desktop, ~760px on mobile
    final double boxSize = widget.isMobile ? 11.5 : 15.5;
    final double boxGap = widget.isMobile ? 3.2 : 4.5;

    final double gridWidth = cols * boxSize + (cols - 1) * boxGap;
    final double gridHeight = rows * boxSize + (rows - 1) * boxGap;

    // Extra padding around grid so hover bubble scaling (up to 1.25x) doesn't clip
    final double extraPad = boxSize * 0.9;
    final double canvasWidth = gridWidth + extraPad * 2;
    final double canvasHeight = gridHeight + extraPad * 2;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: MouseRegion(
            cursor: SystemMouseCursors.basic,
            onHover: (event) {
              setState(() {
                _hoverPos = event.localPosition;
              });
            },
            onExit: (_) {
              setState(() {
                _hoverPos = null;
              });
            },
            child: RepaintBoundary(
              child: SizedBox(
                width: canvasWidth,
                height: canvasHeight,
                child: CustomPaint(
                  size: Size(canvasWidth, canvasHeight),
                  painter: _GithubOneYearBubblePainter(
                    cols: cols,
                    rows: rows,
                    boxSize: boxSize,
                    boxGap: boxGap,
                    extraPad: extraPad,
                    hoverPos: _hoverPos,
                    isMobile: widget.isMobile,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter rendering the 52-week full year of hand-drawn sketch boxes
/// with double-pencil outlines and an interactive bubble scale effect on hover.
class _GithubOneYearBubblePainter extends CustomPainter {
  final int cols;
  final int rows;
  final double boxSize;
  final double boxGap;
  final double extraPad;
  final Offset? hoverPos;
  final bool isMobile;

  const _GithubOneYearBubblePainter({
    required this.cols,
    required this.rows,
    required this.boxSize,
    required this.boxGap,
    required this.extraPad,
    required this.hoverPos,
    required this.isMobile,
  });

  /// Deterministic activity level generator (364 boxes)
  int _getActivityLevel(int col, int row) {
    final double raw =
        (math.sin(col * 12.9898 + row * 78.233 + 42.0) * 43758.5453) % 1.0;
    final double val = raw.abs();

    final bool isWeekday = row >= 1 && row <= 5;
    final double threshold = isWeekday ? 0.22 : 0.45;

    if (val < threshold) return 0;
    if (val < threshold + 0.26) return 1;
    if (val < threshold + 0.50) return 2;
    if (val < threshold + 0.70) return 3;
    return 4;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int boxSeed = 100;
    final double bubbleRadius = boxSize * 4.2;

    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        final double x = extraPad + c * (boxSize + boxGap);
        final double y = extraPad + r * (boxSize + boxGap);
        final Rect rect = Rect.fromLTWH(x, y, boxSize, boxSize);
        final Offset boxCenter = Offset(x + boxSize * 0.5, y + boxSize * 0.5);

        // Calculate interactive bubble scale factor
        double scale = 1.0;
        if (hoverPos != null) {
          final double dist = (boxCenter - hoverPos!).distance;
          if (dist < bubbleRadius) {
            final double norm = (1.0 - (dist / bubbleRadius));
            // Subtle, fluid bubble falloff (scales up ~1.22x max under cursor)
            scale = 1.0 + (0.22 * norm * norm);
          }
        }

        final int level = _getActivityLevel(c, r);

        if (scale > 1.001) {
          canvas.save();
          canvas.translate(boxCenter.dx, boxCenter.dy);
          canvas.scale(scale);
          canvas.translate(-boxCenter.dx, -boxCenter.dy);
          _drawSketchBox(canvas, rect, level, boxSeed++, isHovered: true);
          canvas.restore();
        } else {
          _drawSketchBox(canvas, rect, level, boxSeed++, isHovered: false);
        }
      }
    }
  }

  /// Draws a single box with double-pencil wobble outlines (matching buttons and navbar)
  void _drawSketchBox(
    Canvas canvas,
    Rect rect,
    int level,
    int seed, {
    required bool isHovered,
  }) {
    // Hand tremor jitter for corners and edges
    final double j1 = math.sin(seed * 1.3) * 0.40;
    final double j2 = math.cos(seed * 2.1) * 0.40;
    final double j3 = math.sin(seed * 3.7) * 0.40;
    final double j4 = math.cos(seed * 4.9) * 0.40;

    final double midJ1 = math.sin(seed * 5.3) * 0.35;
    final double midJ2 = math.cos(seed * 6.7) * 0.35;
    final double midJ3 = math.sin(seed * 7.9) * 0.35;
    final double midJ4 = math.cos(seed * 8.3) * 0.35;

    const double rad = 2.4;

    // Primary wobbly pencil outline path
    final Path primaryPath = Path();
    primaryPath.moveTo(rect.left + rad + j1, rect.top);
    primaryPath.quadraticBezierTo(
      rect.center.dx,
      rect.top + midJ1,
      rect.right - rad + j2,
      rect.top,
    );
    primaryPath.quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + rad);
    primaryPath.quadraticBezierTo(
      rect.right + midJ2,
      rect.center.dy,
      rect.right,
      rect.bottom - rad + j3,
    );
    primaryPath.quadraticBezierTo(rect.right, rect.bottom, rect.right - rad, rect.bottom);
    primaryPath.quadraticBezierTo(
      rect.center.dx,
      rect.bottom + midJ3,
      rect.left + rad + j4,
      rect.bottom,
    );
    primaryPath.quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - rad);
    primaryPath.quadraticBezierTo(
      rect.left + midJ4,
      rect.center.dy,
      rect.left,
      rect.top + rad + j1,
    );
    primaryPath.quadraticBezierTo(rect.left, rect.top, rect.left + rad + j1, rect.top);
    primaryPath.close();

    // Outline stroke width and alpha based on activity level
    double strokeWidth;
    double alpha;

    switch (level) {
      case 0:
        strokeWidth = 0.95;
        alpha = isHovered ? 0.45 : 0.22;
        break;
      case 1:
        strokeWidth = 1.25;
        alpha = isHovered ? 0.70 : 0.48;
        break;
      case 2:
        strokeWidth = 1.55;
        alpha = isHovered ? 0.90 : 0.75;
        break;
      case 3:
        strokeWidth = 1.85;
        alpha = isHovered ? 1.00 : 0.90;
        break;
      case 4:
      default:
        strokeWidth = 2.15;
        alpha = 1.00;
        break;
    }

    // 1. Primary Charcoal Pencil Stroke
    final Paint primaryPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(primaryPath, primaryPaint);

    // 2. Secondary Lighter Graphite Pencil Stroke (The authentic button/navbar double-pencil look)
    final Path secondaryPath = Path();
    const double jOff = 0.65;
    secondaryPath.moveTo(rect.left + rad + j1 + jOff, rect.top + jOff);
    secondaryPath.quadraticBezierTo(
      rect.center.dx,
      rect.top + midJ1 + jOff,
      rect.right - rad + j2 - jOff,
      rect.top,
    );
    secondaryPath.quadraticBezierTo(rect.right + jOff, rect.top, rect.right, rect.top + rad);
    secondaryPath.quadraticBezierTo(
      rect.right,
      rect.center.dy + midJ2,
      rect.right,
      rect.bottom - rad + j3 + jOff,
    );
    secondaryPath.quadraticBezierTo(rect.right, rect.bottom + jOff, rect.right - rad, rect.bottom);
    secondaryPath.quadraticBezierTo(
      rect.center.dx,
      rect.bottom + midJ3 - jOff,
      rect.left + rad + j4 - jOff,
      rect.bottom + jOff,
    );
    secondaryPath.quadraticBezierTo(rect.left - jOff, rect.bottom, rect.left, rect.bottom - rad);
    secondaryPath.quadraticBezierTo(
      rect.left,
      rect.center.dy - midJ4,
      rect.left + jOff,
      rect.top + rad + j1,
    );
    secondaryPath.quadraticBezierTo(rect.left, rect.top + jOff, rect.left + rad + j1, rect.top);
    secondaryPath.close();

    final Paint secondaryPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: alpha * 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = (strokeWidth * 0.65).clamp(0.6, 1.3)
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(secondaryPath, secondaryPaint);

    // 3. Hand-Drawn Pencil Hatchings Inside Active Boxes
    final double inset = boxSize * 0.22;

    if (level >= 2) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 2 ? 0.38 : (level == 3 ? 0.68 : 0.88),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round;

      // Primary diagonal pencil stroke
      canvas.drawLine(
        Offset(rect.left + inset, rect.bottom - inset),
        Offset(rect.right - inset, rect.top + inset),
        hatchPaint,
      );
    }

    if (level >= 3) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 3 ? 0.62 : 0.85,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.95
        ..strokeCap = StrokeCap.round;

      // Parallel diagonal strokes
      canvas.drawLine(
        Offset(rect.left + inset, rect.top + rect.height * 0.5),
        Offset(rect.left + rect.width * 0.5, rect.top + inset),
        hatchPaint,
      );
      canvas.drawLine(
        Offset(rect.left + rect.width * 0.5, rect.bottom - inset),
        Offset(rect.right - inset, rect.top + rect.height * 0.5),
        hatchPaint,
      );
    }

    if (level >= 4) {
      final Paint crossPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(alpha: 0.78)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.95
        ..strokeCap = StrokeCap.round;

      // Counter-diagonal cross-hatch for peak intensity
      canvas.drawLine(
        Offset(rect.left + inset, rect.top + inset),
        Offset(rect.right - inset, rect.bottom - inset),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GithubOneYearBubblePainter oldDelegate) {
    return oldDelegate.cols != cols ||
        oldDelegate.rows != rows ||
        oldDelegate.boxSize != boxSize ||
        oldDelegate.boxGap != boxGap ||
        oldDelegate.hoverPos != hoverPos ||
        oldDelegate.isMobile != isMobile;
  }
}
