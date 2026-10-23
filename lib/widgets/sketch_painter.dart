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

/// A hand-drawn semi-translucent parchment drafting tape strip with torn edges.
/// Can be pinned to card corners for an authentic draftsman studio aesthetic.
class SketchTape extends StatelessWidget {
  final double width;
  final double height;
  final double angle;
  final Color? color;
  final String? label;

  const SketchTape({
    super.key,
    this.width = 100.0,
    this.height = 24.0,
    this.angle = -0.05,
    this.color,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: CustomPaint(
        size: Size(width, height),
        painter: _SketchTapePainter(
          tapeColor: color ?? AppColors.primary.withValues(alpha: 0.08),
          borderColor: AppColors.textMain.withValues(alpha: 0.35),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: label != null
              ? Center(
                  child: Text(
                    label!,
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMain.withValues(alpha: 0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _SketchTapePainter extends CustomPainter {
  final Color tapeColor;
  final Color borderColor;

  _SketchTapePainter({required this.tapeColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) return;

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(w, 0);

    const int jagCount = 4;
    final double jagStep = h / jagCount;
    for (int i = 0; i < jagCount; i++) {
      final double midY = i * jagStep + jagStep * 0.5;
      final double endY = (i + 1) * jagStep;
      final double jagX = (i % 2 == 0) ? w - 3.5 : w + 2.0;
      path.lineTo(jagX, midY);
      path.lineTo(w, endY);
    }

    path.lineTo(0, h);

    for (int i = jagCount; i > 0; i--) {
      final double midY = i * jagStep - jagStep * 0.5;
      final double endY = (i - 1) * jagStep;
      final double jagX = (i % 2 == 0) ? -2.5 : 2.5;
      path.lineTo(jagX, midY);
      path.lineTo(0, endY);
    }
    path.close();

    final Paint fillPaint = Paint()
      ..color = tapeColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    final Paint strokePaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SketchTapePainter oldDelegate) {
    return oldDelegate.tapeColor != tapeColor ||
        oldDelegate.borderColor != borderColor;
  }
}

/// An artisanal circular hand-drawn postal / inspection stamp that tilts & spins on hover.
class SketchStamp extends StatefulWidget {
  final String text;
  final String subtext;
  final IconData? icon;
  final double size;
  final double initialAngle;

  const SketchStamp({
    super.key,
    required this.text,
    this.subtext = '2026 // SPEC',
    this.icon,
    this.size = 84.0,
    this.initialAngle = -0.07,
  });

  @override
  State<SketchStamp> createState() => _SketchStampState();
}

class _SketchStampState extends State<SketchStamp> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedRotation(
        turns: _isHovered ? 0.02 : (widget.initialAngle / (2 * math.pi)),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutBack,
        child: AnimatedScale(
          scale: _isHovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _SketchStampPainter(
              color: AppColors.primary.withValues(
                alpha: _isHovered ? 0.85 : 0.65,
              ),
              seed: 57,
            ),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: widget.size * 0.22,
                      color: AppColors.primary.withValues(
                        alpha: _isHovered ? 0.85 : 0.65,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: widget.size * 0.12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary.withValues(
                        alpha: _isHovered ? 0.85 : 0.65,
                      ),
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtext,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: widget.size * 0.09,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary.withValues(
                        alpha: _isHovered ? 0.85 : 0.65,
                      ),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SketchStampPainter extends CustomPainter {
  final Color color;
  final int seed;

  _SketchStampPainter({required this.color, required this.seed});

  double _noise(int step) {
    return math.sin(step * 2.718 + seed * 1.618) * 0.6 +
        math.cos(step * 3.141 - seed * 0.876) * 0.4;
  }

  Path _buildWobblyCircle(
    Offset center,
    double radius,
    int stepStart,
    double amp,
  ) {
    final Path path = Path();
    const int segments = 12;
    int step = stepStart;

    final List<Offset> points = [];
    for (int i = 0; i < segments; i++) {
      final double theta = (i / segments) * 2 * math.pi;
      final double r = radius + _noise(step++) * amp;
      final double x = center.dx + r * math.cos(theta);
      final double y = center.dy + r * math.sin(theta);
      points.add(Offset(x, y));
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < segments; i++) {
      final Offset current = points[i];
      final Offset next = points[(i + 1) % segments];
      final double ctrlX =
          (current.dx + next.dx) * 0.5 + _noise(step++) * (amp * 0.5);
      final double ctrlY =
          (current.dy + next.dy) * 0.5 + _noise(step++) * (amp * 0.5);
      path.quadraticBezierTo(ctrlX, ctrlY, next.dx, next.dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = (math.min(size.width, size.height) * 0.5) - 3.0;
    if (radius <= 0) return;

    // Outer wobbly circle
    final Path outer = _buildWobblyCircle(center, radius, 1, 1.8);
    final Paint outerPaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(outer, outerPaint);

    // Inner wobbly dashed ring
    final Path inner = _buildWobblyCircle(center, radius * 0.80, 20, 1.3);
    final Paint innerPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(inner, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchStampPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.seed != seed;
  }
}
