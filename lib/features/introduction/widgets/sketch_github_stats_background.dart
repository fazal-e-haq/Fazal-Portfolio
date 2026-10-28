import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A handcrafted pencil-sketch GitHub Contribution Heatmap backdrop.
/// Renders purely the very big hand-drawn contribution boxes floating in the background
/// behind Fazal's portrait with pure charcoal black outlines (no card border, no text, no dates).
class SketchGithubStatsBackground extends StatelessWidget {
  const SketchGithubStatsBackground({
    super.key,
    required this.width,
    required this.height,
    this.isMobile = false,
  });

  final double width;
  final double height;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    // Very big boxes as requested: 38px on desktop, 26px on mobile
    final double boxSize = isMobile ? 26.0 : 38.0;
    final double boxGap = isMobile ? 6.5 : 9.5;

    // Calculate maximum columns and rows that fit comfortably
    final int cols = ((width + boxGap) / (boxSize + boxGap)).floor().clamp(6, 14);
    final int rows = ((height + boxGap) / (boxSize + boxGap)).floor().clamp(4, 7);

    final double actualGridWidth = cols * boxSize + (cols - 1) * boxGap;
    final double actualGridHeight = rows * boxSize + (rows - 1) * boxGap;

    return RepaintBoundary(
      child: SizedBox(
        width: actualGridWidth,
        height: actualGridHeight,
        child: CustomPaint(
          size: Size(actualGridWidth, actualGridHeight),
          painter: _GithubBigBoxesPainter(
            cols: cols,
            rows: rows,
            boxSize: boxSize,
            boxGap: boxGap,
            isMobile: isMobile,
          ),
        ),
      ),
    );
  }
}

/// Custom painter rendering the matrix of very big hand-drawn GitHub contribution boxes.
class _GithubBigBoxesPainter extends CustomPainter {
  final int cols;
  final int rows;
  final double boxSize;
  final double boxGap;
  final bool isMobile;

  const _GithubBigBoxesPainter({
    required this.cols,
    required this.rows,
    required this.boxSize,
    required this.boxGap,
    required this.isMobile,
  });

  /// Deterministic activity level generator to simulate realistic GitHub heatmap
  /// streaks without any frame-to-frame flickering.
  int _getActivityLevel(int col, int row) {
    // Golden ratio hash for natural pseudo-random distribution
    final double raw = (math.sin(col * 12.9898 + row * 78.233 + 42.0) * 43758.5453) % 1.0;
    final double val = raw.abs();

    // Weekdays (Mon-Fri, rows 1-5) have higher commit probability
    final bool isWeekday = row >= 1 && row <= 5;
    final double threshold = isWeekday ? 0.22 : 0.45;

    if (val < threshold) return 0; // Inactive
    if (val < threshold + 0.26) return 1; // Light
    if (val < threshold + 0.50) return 2; // Medium
    if (val < threshold + 0.70) return 3; // High
    return 4; // Peak
  }

  @override
  void paint(Canvas canvas, Size size) {
    int boxSeed = 100;

    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        final double x = c * (boxSize + boxGap);
        final double y = r * (boxSize + boxGap);
        final Rect rect = Rect.fromLTWH(x, y, boxSize, boxSize);

        final int level = _getActivityLevel(c, r);
        _drawSketchBox(canvas, rect, level, boxSeed++);
      }
    }
  }

  void _drawSketchBox(Canvas canvas, Rect rect, int level, int seed) {
    // Deterministic corner tremor (0.45px) for natural hand-drawn feel
    final double j1 = math.sin(seed * 1.3) * 0.45;
    final double j2 = math.cos(seed * 2.1) * 0.45;
    final double j3 = math.sin(seed * 3.7) * 0.45;
    final double j4 = math.cos(seed * 4.9) * 0.45;

    final Path boxPath = Path();
    final double rad = isMobile ? 3.0 : 4.0;
    boxPath.moveTo(rect.left + rad + j1, rect.top);
    boxPath.lineTo(rect.right - rad + j2, rect.top);
    boxPath.quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + rad);
    boxPath.lineTo(rect.right, rect.bottom - rad + j3);
    boxPath.quadraticBezierTo(rect.right, rect.bottom, rect.right - rad, rect.bottom);
    boxPath.lineTo(rect.left + rad + j4, rect.bottom);
    boxPath.quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - rad);
    boxPath.lineTo(rect.left, rect.top + rad + j1);
    boxPath.quadraticBezierTo(rect.left, rect.top, rect.left + rad + j1, rect.top);
    boxPath.close();

    // Outline stroke styling strictly in charcoal black
    double strokeWidth;
    double alpha;

    switch (level) {
      case 0:
        strokeWidth = isMobile ? 1.0 : 1.3;
        alpha = 0.22; // Faint outline
        break;
      case 1:
        strokeWidth = isMobile ? 1.3 : 1.7;
        alpha = 0.48; // Crisp sketch line
        break;
      case 2:
        strokeWidth = isMobile ? 1.6 : 2.1;
        alpha = 0.75; // Bolder outline
        break;
      case 3:
        strokeWidth = isMobile ? 1.9 : 2.5;
        alpha = 0.90; // Dark outline
        break;
      case 4:
      default:
        strokeWidth = isMobile ? 2.2 : 2.8;
        alpha = 1.00; // Solid ink outline
        break;
    }

    final Paint outlinePaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(boxPath, outlinePaint);

    // Hand-drawn pencil hatch lines inside active boxes (Strictly Black!)
    final double inset = isMobile ? 4.0 : 6.0;

    if (level >= 2) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 2 ? 0.38 : (level == 3 ? 0.68 : 0.88),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = isMobile ? 1.0 : 1.3
        ..strokeCap = StrokeCap.round;

      // Primary diagonal pencil stroke across the big box
      canvas.drawLine(
        Offset(rect.left + inset, rect.bottom - inset),
        Offset(rect.right - inset, rect.top + inset),
        hatchPaint,
      );
    }

    if (level >= 3) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 3 ? 0.65 : 0.85,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = isMobile ? 1.0 : 1.2
        ..strokeCap = StrokeCap.round;

      // Secondary parallel diagonal strokes
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
        ..strokeWidth = isMobile ? 1.0 : 1.2
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
  bool shouldRepaint(covariant _GithubBigBoxesPainter oldDelegate) {
    return oldDelegate.cols != cols ||
        oldDelegate.rows != rows ||
        oldDelegate.boxSize != boxSize ||
        oldDelegate.boxGap != boxGap ||
        oldDelegate.isMobile != isMobile;
  }
}
