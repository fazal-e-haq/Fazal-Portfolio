import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A handcrafted pencil-sketch GitHub Contribution Heatmap backdrop (Full One Year / 52 Weeks).
/// Displays hand-drawn boxes identical in style to SketchButton & SketchCard:
/// - Multi-pass wobbly graphite & charcoal strokes (no straight lines)
/// - Authentic hand-drawn corner overshoot at top-left
/// - Dual overlapping sketch passes with organic noise
/// - Interactive hover bubble scale effect (smooth ripple scaling under cursor)
/// - Zero card border, zero text, zero dates, centered behind Fazal's portrait
class SketchGithubStatsBackground extends StatefulWidget {
  const SketchGithubStatsBackground({
    super.key,
    required this.width,
    this.height,
    this.isMobile = false,
    this.mobileCols = 20,
  });

  final double width;
  final double? height;
  final bool isMobile;
  final int mobileCols;

  @override
  State<SketchGithubStatsBackground> createState() =>
      _SketchGithubStatsBackgroundState();
}

class _SketchGithubStatsBackgroundState
    extends State<SketchGithubStatsBackground> {
  Offset? _hoverPos;

  @override
  Widget build(BuildContext context) {
    // 52 weeks on desktop (full year), or adapted column count on mobile
    final int cols = widget.isMobile ? widget.mobileCols : 52;
    const int rows = 7;

    // Box dimensions: full year grid width ~1760px on desktop, ~490px on mobile
    final double boxSize = widget.isMobile ? 18.0 : 27.0;
    final double boxGap = widget.isMobile ? 4.5 : 6.0;

    final double gridWidth = cols * boxSize + (cols - 1) * boxGap;
    final double gridHeight = rows * boxSize + (rows - 1) * boxGap;

    // Extra padding around grid so hover bubble scaling (up to 1.25x) doesn't clip
    final double extraPad = boxSize * 0.95;
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

/// Custom painter rendering the full year or mobile sketch boxes
/// using the exact multi-pass wobbly pencil algorithm from SketchCard & SketchButton.
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

  /// Deterministic organic noise perturbation (identical formula to SketchPainter)
  double _noise(int step, int passSeed) {
    return math.sin(step * 2.39996 + passSeed * 1.61803) * 0.65 +
        math.cos(step * 4.12345 - passSeed * 0.87654) * 0.35;
  }

  /// Builds an authentic hand-drawn sketch box path matching SketchBorderPainter:
  /// - Curved quadratic bezier segments with normal offsets
  /// - Organic corner rounding
  /// - Realistic pencil overshoot where line loops back past the starting point
  Path _buildWobblyBoxPath({
    required Size size,
    required int passSeed,
    required double amp,
    required double inset,
    required double borderRadius,
  }) {
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) return Path();

    final double maxRadius = math.min(w, h) * 0.42;
    final double r = borderRadius.clamp(0.0, maxRadius);
    final double left = inset;
    final double top = inset;
    final double right = w - inset;
    final double bottom = h - inset;

    final Path path = Path();
    int step = 1;

    void addWobblyEdge(
      double x0,
      double y0,
      double x1,
      double y1, {
      required double nx,
      required double ny,
    }) {
      final double dx = x1 - x0;
      final double dy = y1 - y0;
      const int segments = 2;

      double prevX = x0;
      double prevY = y0;

      for (int i = 1; i <= segments; i++) {
        final double t = i / segments;
        final double tMid = (i - 0.5) / segments;

        final double edgeEnvelope = math.sin(t * math.pi);
        final double midEnvelope = math.sin(tMid * math.pi);

        final double offsetEnd =
            (i == segments
                ? _noise(step, passSeed) * 0.35
                : _noise(step, passSeed)) *
            amp *
            (0.35 + 0.65 * edgeEnvelope);
        step++;

        final double offsetCtrl =
            _noise(step, passSeed) * amp * (0.45 + 0.75 * midEnvelope);
        step++;

        final double targetX = x0 + dx * t + nx * offsetEnd;
        final double targetY = y0 + dy * t + ny * offsetEnd;

        final double ctrlX = (prevX + targetX) * 0.5 + nx * offsetCtrl;
        final double ctrlY = (prevY + targetY) * 0.5 + ny * offsetCtrl;

        path.quadraticBezierTo(ctrlX, ctrlY, targetX, targetY);
        prevX = targetX;
        prevY = targetY;
      }
    }

    // Start at top-left after corner radius
    final double startX = left + r + _noise(step++, passSeed) * (amp * 0.4);
    final double startY = top + _noise(step++, passSeed) * (amp * 0.5);
    path.moveTo(startX, startY);

    // 1. Top Edge (left -> right), normal points up (0, -1)
    addWobblyEdge(startX, startY, right - r, top, nx: 0.0, ny: -1.0);

    // Top-Right Corner
    final double trCtrlX = right + _noise(step++, passSeed) * (amp * 0.75);
    final double trCtrlY = top + _noise(step++, passSeed) * (amp * 0.75);
    final double trEndX = right + _noise(step++, passSeed) * (amp * 0.4);
    final double trEndY = top + r + _noise(step++, passSeed) * (amp * 0.4);
    path.quadraticBezierTo(trCtrlX, trCtrlY, trEndX, trEndY);

    // 2. Right Edge (top -> bottom), normal points right (1, 0)
    addWobblyEdge(trEndX, trEndY, right, bottom - r, nx: 1.0, ny: 0.0);

    // Bottom-Right Corner
    final double brCtrlX = right + _noise(step++, passSeed) * (amp * 0.75);
    final double brCtrlY = bottom + _noise(step++, passSeed) * (amp * 0.75);
    final double brEndX = right - r + _noise(step++, passSeed) * (amp * 0.4);
    final double brEndY = bottom + _noise(step++, passSeed) * (amp * 0.5);
    path.quadraticBezierTo(brCtrlX, brCtrlY, brEndX, brEndY);

    // 3. Bottom Edge (right -> left), normal points down (0, 1)
    addWobblyEdge(brEndX, brEndY, left + r, bottom, nx: 0.0, ny: 1.0);

    // Bottom-Left Corner
    final double blCtrlX = left + _noise(step++, passSeed) * (amp * 0.75);
    final double blCtrlY = bottom + _noise(step++, passSeed) * (amp * 0.75);
    final double blEndX = left + _noise(step++, passSeed) * (amp * 0.4);
    final double blEndY = bottom - r + _noise(step++, passSeed) * (amp * 0.4);
    path.quadraticBezierTo(blCtrlX, blCtrlY, blEndX, blEndY);

    // 4. Left Edge (bottom -> top), normal points left (-1, 0)
    addWobblyEdge(blEndX, blEndY, left, top + r, nx: -1.0, ny: 0.0);

    // Top-Left Corner closing back with authentic pencil overshoot!
    final double tlCtrlX = left + _noise(step++, passSeed) * (amp * 0.75);
    final double tlCtrlY = top + _noise(step++, passSeed) * (amp * 0.75);
    final double overshootX = startX + (amp * 1.5);
    final double overshootY = startY + _noise(step++, passSeed) * (amp * 0.4);
    path.quadraticBezierTo(tlCtrlX, tlCtrlY, overshootX, overshootY);

    return path;
  }

  /// Deterministic activity level generator
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
    final double wobble = isMobile ? 1.15 : 1.55;
    final double borderRadius = isMobile ? 3.4 : 4.8;

    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        final double x = extraPad + c * (boxSize + boxGap);
        final double y = extraPad + r * (boxSize + boxGap);
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
        final int seed = boxSeed++;

        canvas.save();
        canvas.translate(x, y);

        if (scale > 1.001) {
          canvas.translate(boxSize * 0.5, boxSize * 0.5);
          canvas.scale(scale);
          canvas.translate(-boxSize * 0.5, -boxSize * 0.5);
          _drawSketchBox(
            canvas,
            Size(boxSize, boxSize),
            level,
            seed,
            isHovered: true,
            wobble: wobble,
            borderRadius: borderRadius,
          );
        } else {
          _drawSketchBox(
            canvas,
            Size(boxSize, boxSize),
            level,
            seed,
            isHovered: false,
            wobble: wobble,
            borderRadius: borderRadius,
          );
        }

        canvas.restore();
      }
    }
  }

  /// Draws a single box with authentic multi-pass hand-drawn sketch strokes matching SketchCard & SketchButton
  void _drawSketchBox(
    Canvas canvas,
    Size size,
    int level,
    int seed, {
    required bool isHovered,
    required double wobble,
    required double borderRadius,
  }) {
    // Outline stroke width and alpha based on activity level
    double strokeWidth;
    double alpha;

    switch (level) {
      case 0:
        strokeWidth = 1.30;
        alpha = isHovered ? 0.50 : 0.26;
        break;
      case 1:
        strokeWidth = 1.70;
        alpha = isHovered ? 0.76 : 0.54;
        break;
      case 2:
        strokeWidth = 2.10;
        alpha = isHovered ? 0.95 : 0.80;
        break;
      case 3:
        strokeWidth = 2.50;
        alpha = isHovered ? 1.00 : 0.92;
        break;
      case 4:
      default:
        strokeWidth = 2.90;
        alpha = 1.00;
        break;
    }

    // 1. Secondary Loose Graphite Sketch Pass (underneath, exactly matching SketchBorderPainter)
    final Path secondaryPath = _buildWobblyBoxPath(
      size: size,
      passSeed: seed + 37,
      amp: wobble * 1.35,
      inset: 1.1,
      borderRadius: borderRadius,
    );

    final Paint secondaryPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(
        alpha: (alpha * (isHovered ? 0.52 : 0.36)).clamp(0.14, 0.58),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = (strokeWidth * 0.65).clamp(0.85, 1.85)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(secondaryPath, secondaryPaint);

    // 2. Optional Third Sketch Stroke on Hover (for tactile sketch feedback)
    if (isHovered) {
      final Path hoverPath = _buildWobblyBoxPath(
        size: size,
        passSeed: seed + 91,
        amp: wobble * 1.60,
        inset: 0.0,
        borderRadius: borderRadius,
      );

      final Paint hoverPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 0.55
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPath(hoverPath, hoverPaint);
    }

    // 3. Primary Charcoal Pencil Stroke (main pass with organic overshoot)
    final Path primaryPath = _buildWobblyBoxPath(
      size: size,
      passSeed: seed,
      amp: wobble,
      inset: 0.55,
      borderRadius: borderRadius,
    );

    final Paint primaryPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? strokeWidth + 0.35 : strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(primaryPath, primaryPaint);

    // 4. Hand-Drawn Pencil Hatchings Inside Active Boxes
    final double inset = size.width * 0.24;

    if (level >= 2) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 2 ? 0.42 : (level == 3 ? 0.72 : 0.92),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.35
        ..strokeCap = StrokeCap.round;

      // Primary diagonal pencil stroke with subtle hand tremor
      final Path hatchPath = Path();
      final double x0 = inset;
      final double y0 = size.height - inset;
      final double x1 = size.width - inset;
      final double y1 = inset;
      final double ctrlX = (x0 + x1) * 0.5 + _noise(seed + 1, seed) * 0.6;
      final double ctrlY = (y0 + y1) * 0.5 + _noise(seed + 2, seed) * 0.6;
      hatchPath.moveTo(x0, y0);
      hatchPath.quadraticBezierTo(ctrlX, ctrlY, x1, y1);
      canvas.drawPath(hatchPath, hatchPaint);
    }

    if (level >= 3) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 3 ? 0.64 : 0.88,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25
        ..strokeCap = StrokeCap.round;

      // Parallel diagonal strokes
      final Path p1 = Path();
      p1.moveTo(inset, size.height * 0.5);
      p1.lineTo(size.width * 0.5, inset);
      canvas.drawPath(p1, hatchPaint);

      final Path p2 = Path();
      p2.moveTo(size.width * 0.5, size.height - inset);
      p2.lineTo(size.width - inset, size.height * 0.5);
      canvas.drawPath(p2, hatchPaint);
    }

    if (level >= 4) {
      final Paint crossPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(alpha: 0.82)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25
        ..strokeCap = StrokeCap.round;

      // Counter-diagonal cross-hatch for peak intensity
      final Path crossPath = Path();
      final double cx0 = inset;
      final double cy0 = inset;
      final double cx1 = size.width - inset;
      final double cy1 = size.height - inset;
      final double ctrlX = (cx0 + cx1) * 0.5 + _noise(seed + 3, seed) * 0.6;
      final double ctrlY = (cy0 + cy1) * 0.5 + _noise(seed + 4, seed) * 0.6;
      crossPath.moveTo(cx0, cy0);
      crossPath.quadraticBezierTo(ctrlX, ctrlY, cx1, cy1);
      canvas.drawPath(crossPath, crossPaint);
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
