import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/themes/theme.dart';

/// Custom painter that draws a hand-drawn pencil border with NO perfect straight lines.
/// Uses deterministic multi-segment quadratic Bezier curves with organic wave perturbations
/// and a secondary overlapping graphite sketch pass.
class SketchBorderPainter extends CustomPainter {
  final Color color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double borderRadius;
  final double wobble;
  final int seed;
  final bool isHovered;
  final double zigzagProgress;

  const SketchBorderPainter({
    this.color = AppColors.textMain,
    this.backgroundColor,
    this.strokeWidth = 2.2,
    this.borderRadius = 16.0,
    this.wobble = 2.0,
    this.seed = 1,
    this.isHovered = false,
    this.zigzagProgress = 0.0,
  });

  double _noise(int step, int passSeed) {
    final double v =
        math.sin(step * 2.39996 + passSeed * 1.61803) * 0.65 +
        math.cos(step * 4.12345 - passSeed * 0.87654) * 0.35;
    return v;
  }

  Path _buildZigzagFillPath(
    Size size, {
    required int passSeed,
    required double progress,
  }) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0 || progress <= 0.0) return path;

    const double spacing = 9.5;
    final double slant = h * 0.55;
    final double totalSpan = w + slant + spacing * 2;
    final int totalStrokes = (totalSpan / spacing).ceil().clamp(4, 90);
    final double activeStrokesExact = totalStrokes * progress.clamp(0.0, 1.0);
    final int fullStrokes = activeStrokesExact.floor();
    final double partialStroke = activeStrokesExact - fullStrokes;

    bool goingDown = true;
    int step = 1;

    for (int i = 0; i <= fullStrokes && i < totalStrokes; i++) {
      final double tStroke = (i == fullStrokes) ? partialStroke : 1.0;
      if (tStroke <= 0.01) break;

      final double baseX = -slant + i * spacing;
      final double topX = baseX + slant + _noise(step++, passSeed) * 2.2;
      final double topY = -2.0 + _noise(step++, passSeed) * 1.8;
      final double botX = baseX + _noise(step++, passSeed) * 2.2;
      final double botY = h + 2.0 + _noise(step++, passSeed) * 1.8;

      final double startX = goingDown ? topX : botX;
      final double startY = goingDown ? topY : botY;
      final double targetEndX = goingDown ? botX : topX;
      final double targetEndY = goingDown ? botY : topY;

      final double endX = startX + (targetEndX - startX) * tStroke;
      final double endY = startY + (targetEndY - startY) * tStroke;

      final double ctrlX =
          (startX + endX) * 0.5 + _noise(step++, passSeed) * 3.0;
      final double ctrlY =
          (startY + endY) * 0.5 + _noise(step++, passSeed) * 2.2;

      if (i == 0) {
        path.moveTo(startX, startY);
      } else {
        // Connect turnaround with a quick organic pencil loop/corner
        final double turnCtrlX = startX + _noise(step++, passSeed) * 2.4;
        final double turnCtrlY = startY + (goingDown ? -2.5 : 2.5);
        path.quadraticBezierTo(turnCtrlX, turnCtrlY, startX, startY);
      }

      path.quadraticBezierTo(ctrlX, ctrlY, endX, endY);
      goingDown = !goingDown;
    }

    return path;
  }

  Path _buildWobblyRectPath(
    Size size, {
    required int passSeed,
    required double amp,
    required double inset,
  }) {
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) return Path();

    final double maxRadius = math.max(0.0, math.min(w, h) * 0.45);
    final double r = borderRadius.clamp(0.0, maxRadius);
    final double left = inset;
    final double top = inset;
    final double right = w - inset;
    final double bottom = h - inset;

    final Path path = Path();
    int step = 1;

    // Helper to draw a wobbly line from (x0, y0) to (x1, y1)
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
      final double length = math.sqrt(dx * dx + dy * dy);
      final int segments = (length / 32.0).round().clamp(3, 14);

      double prevX = x0;
      double prevY = y0;

      for (int i = 1; i <= segments; i++) {
        final double t = i / segments;
        final double tMid = (i - 0.5) / segments;

        // Taper wobble near corners so corners connect smoothly
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
    final double trCtrlX = right + _noise(step++, passSeed) * (amp * 0.8);
    final double trCtrlY = top + _noise(step++, passSeed) * (amp * 0.8);
    final double trEndX = right + _noise(step++, passSeed) * (amp * 0.5);
    final double trEndY = top + r + _noise(step++, passSeed) * (amp * 0.4);
    path.quadraticBezierTo(trCtrlX, trCtrlY, trEndX, trEndY);

    // 2. Right Edge (top -> bottom), normal points right (1, 0)
    addWobblyEdge(trEndX, trEndY, right, bottom - r, nx: 1.0, ny: 0.0);

    // Bottom-Right Corner
    final double brCtrlX = right + _noise(step++, passSeed) * (amp * 0.8);
    final double brCtrlY = bottom + _noise(step++, passSeed) * (amp * 0.8);
    final double brEndX = right - r + _noise(step++, passSeed) * (amp * 0.4);
    final double brEndY = bottom + _noise(step++, passSeed) * (amp * 0.5);
    path.quadraticBezierTo(brCtrlX, brCtrlY, brEndX, brEndY);

    // 3. Bottom Edge (right -> left), normal points down (0, 1)
    addWobblyEdge(brEndX, brEndY, left + r, bottom, nx: 0.0, ny: 1.0);

    // Bottom-Left Corner
    final double blCtrlX = left + _noise(step++, passSeed) * (amp * 0.8);
    final double blCtrlY = bottom + _noise(step++, passSeed) * (amp * 0.8);
    final double blEndX = left + _noise(step++, passSeed) * (amp * 0.5);
    final double blEndY = bottom - r + _noise(step++, passSeed) * (amp * 0.4);
    path.quadraticBezierTo(blCtrlX, blCtrlY, blEndX, blEndY);

    // 4. Left Edge (bottom -> top), normal points left (-1, 0)
    addWobblyEdge(blEndX, blEndY, left, top + r, nx: -1.0, ny: 0.0);

    // Top-Left Corner closing back to start, with a slight pencil overshoot
    final double tlCtrlX = left + _noise(step++, passSeed) * (amp * 0.8);
    final double tlCtrlY = top + _noise(step++, passSeed) * (amp * 0.8);
    final double overshootX = startX + (amp * 1.8);
    final double overshootY = startY + _noise(step++, passSeed) * (amp * 0.5);
    path.quadraticBezierTo(tlCtrlX, tlCtrlY, overshootX, overshootY);

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final Path primaryPath = _buildWobblyRectPath(
      size,
      passSeed: seed,
      amp: wobble,
      inset: 1.0,
    );

    // Fill background if provided
    if (backgroundColor != null && backgroundColor != Colors.transparent) {
      final Paint fillPaint = Paint()
        ..color = backgroundColor!
        ..style = PaintingStyle.fill;
      canvas.drawPath(primaryPath, fillPaint);
    }

    // Draw animated hand-drawn pencil zigzag shading inside the border on hover
    if (zigzagProgress > 0.01) {
      canvas.save();
      canvas.clipPath(primaryPath);

      final Paint washPaint = Paint()
        ..color = AppColors.primary.withValues(alpha: 0.08 * zigzagProgress)
        ..style = PaintingStyle.fill;
      canvas.drawPath(primaryPath, washPaint);

      final Path zigzagPrimary = _buildZigzagFillPath(
        size,
        passSeed: seed + 17,
        progress: zigzagProgress,
      );
      final Paint zigzagWarmPaint = Paint()
        ..color = AppColors.primary.withValues(alpha: 0.24 * zigzagProgress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(zigzagPrimary, zigzagWarmPaint);

      final Path zigzagGraphite = _buildZigzagFillPath(
        size,
        passSeed: seed + 53,
        progress: zigzagProgress,
      );
      final Paint zigzagInkPaint = Paint()
        ..color = color.withValues(alpha: 0.17 * zigzagProgress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(zigzagGraphite, zigzagInkPaint);

      canvas.restore();
    }

    // Secondary loose pencil pass (underneath)
    final Path secondaryPath = _buildWobblyRectPath(
      size,
      passSeed: seed + 37,
      amp: wobble * 1.45,
      inset: 2.2,
    );
    final Paint secondaryPaint = Paint()
      ..color = color.withValues(alpha: isHovered ? 0.52 : 0.34)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.65
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(secondaryPath, secondaryPaint);

    // Optional third sketch stroke on hover for tactile feedback
    if (isHovered) {
      final Path hoverPath = _buildWobblyRectPath(
        size,
        passSeed: seed + 91,
        amp: wobble * 1.75,
        inset: 0.0,
      );
      final Paint hoverPaint = Paint()
        ..color = color.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 0.55
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(hoverPath, hoverPaint);
    }

    // Main charcoal pencil stroke
    final Paint primaryPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? strokeWidth + 0.4 : strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(primaryPath, primaryPaint);
  }

  @override
  bool shouldRepaint(covariant SketchBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.wobble != wobble ||
        oldDelegate.seed != seed ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.zigzagProgress != zigzagProgress;
  }
}

/// Custom painter for a single hand-drawn horizontal pencil line (divider or underline).
class SketchLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double wobble;
  final int seed;

  const SketchLinePainter({
    this.color = AppColors.textMain,
    this.strokeWidth = 2.0,
    this.wobble = 1.8,
    this.seed = 7,
  });

  double _noise(int step, int passSeed) {
    return math.sin(step * 2.51 + passSeed * 1.37) * 0.6 +
        math.cos(step * 3.93 - passSeed * 0.91) * 0.4;
  }

  Path _buildLine(Size size, int passSeed, double amp, double yOffset) {
    final Path path = Path();
    final double w = size.width;
    final double midY = size.height * 0.5 + yOffset;
    if (w <= 0) return path;

    final int segments = (w / 28.0).round().clamp(3, 16);
    double prevX = 0;
    double prevY = midY + _noise(0, passSeed) * amp * 0.4;
    path.moveTo(prevX, prevY);

    for (int i = 1; i <= segments; i++) {
      final double t = i / segments;
      final double targetX = w * t;
      final double targetY = midY + _noise(i * 2, passSeed) * amp;
      final double ctrlX = (prevX + targetX) * 0.5;
      final double ctrlY =
          (prevY + targetY) * 0.5 + _noise(i * 2 + 1, passSeed) * amp;
      path.quadraticBezierTo(ctrlX, ctrlY, targetX, targetY);
      prevX = targetX;
      prevY = targetY;
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0) return;

    final Paint secondaryPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.65
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      _buildLine(size, seed + 19, wobble * 1.3, 1.2),
      secondaryPaint,
    );

    final Paint primaryPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(_buildLine(size, seed, wobble, 0.0), primaryPaint);
  }

  @override
  bool shouldRepaint(covariant SketchLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.wobble != wobble ||
        oldDelegate.seed != seed;
  }
}

/// A hand-drawn horizontal pencil divider widget.
class SketchDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;
  final int seed;

  const SketchDivider({
    super.key,
    this.width = double.infinity,
    this.height = 8.0,
    this.color = AppColors.textMain,
    this.strokeWidth = 2.0,
    this.seed = 7,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: SketchLinePainter(
          color: color,
          strokeWidth: strokeWidth,
          seed: seed,
        ),
      ),
    );
  }
}

/// A reusable editorial section header with an expressive hand-lettered title
/// and hand-sketched pencil underline (no boxed section number/tag card).
class SketchSectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isMobile;
  final int seed;

  const SketchSectionHeader({
    super.key,
    this.tag = '',
    required this.title,
    this.subtitle,
    this.isMobile = false,
    this.seed = 11,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: isMobile ? 34 : 48,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        SketchDivider(
          width: isMobile ? 120 : 180,
          height: 10,
          strokeWidth: 2.4,
          seed: seed + 5,
        ),
        const SizedBox(height: 2),
        SketchDivider(
          width: isMobile ? 76 : 112,
          height: 6,
          color: AppColors.primary.withValues(alpha: 0.75),
          strokeWidth: 1.8,
          seed: seed + 19,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: isMobile ? 15 : 17,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// A custom [Decoration] that paints an organic hand-drawn wobbly pencil border
/// using [SketchBorderPainter] (zero straight digital lines).
/// Used for AppBar / Navigation [Tooltip.decoration] and popup badges.
class SketchTooltipDecoration extends Decoration {
  final Color borderColor;
  final Color backgroundColor;
  final double strokeWidth;
  final double borderRadius;
  final double wobble;
  final int seed;

  const SketchTooltipDecoration({
    this.borderColor = AppColors.textMain,
    this.backgroundColor = AppColors.background,
    this.strokeWidth = 1.9,
    this.borderRadius = 10.0,
    this.wobble = 1.5,
    this.seed = 19,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _SketchTooltipBoxPainter(this);
  }
}

class _SketchTooltipBoxPainter extends BoxPainter {
  final SketchTooltipDecoration decoration;

  _SketchTooltipBoxPainter(this.decoration);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Size? size = configuration.size;
    if (size == null || size.width <= 0 || size.height <= 0) return;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final painter = SketchBorderPainter(
      color: decoration.borderColor,
      backgroundColor: decoration.backgroundColor,
      strokeWidth: decoration.strokeWidth,
      borderRadius: decoration.borderRadius,
      wobble: decoration.wobble,
      seed: decoration.seed,
      isHovered: true,
    );
    painter.paint(canvas, size);

    canvas.restore();
  }
}
