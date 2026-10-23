import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/themes/theme.dart';

/// Reusable widget that renders the background "HELLO" watermark in the Hero section.
///
/// Features:
/// - Guaranteed single-line layout via [FittedBox] across Mobile, Tablet, and Desktop.
/// - Smooth sketchbook curtain-parting & fade-out as the user scrolls down.
/// - Auto-playing, sequential letter-by-letter animation cycle (H ➔ E ➔ L ➔ L ➔ O)
///   where each letter automatically transforms into an active card with wobbly
///   pencil frame, diagonal shading, radiating burst lines, and bold deep black color.
/// - Seamlessly supports interactive hover spotlighting on top of the auto wave.
class HelloWatermarkWidget extends StatefulWidget {
  final double screenWidth;
  final bool isMobile;
  final double scrollFade;

  const HelloWatermarkWidget({
    super.key,
    required this.screenWidth,
    required this.isMobile,
    required this.scrollFade,
  });

  @override
  State<HelloWatermarkWidget> createState() => _HelloWatermarkWidgetState();
}

class _HelloWatermarkWidgetState extends State<HelloWatermarkWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _cycleController;

  static const List<String> _letters = ['H', 'E', 'L', 'L', 'O'];

  @override
  void initState() {
    super.initState();
    // 3.8s continuous auto-cycle looping letter by letter
    _cycleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat();
  }

  @override
  void dispose() {
    _cycleController.dispose();
    super.dispose();
  }

  /// Computes the auto-activation value [0.0 - 1.0] for letter at [index].
  double _computeLetterAutoActivation(int index, double progress) {
    const int count = 5;
    const double window = 1.0 / count; // 0.20 per letter
    final double start = index * window;
    final double end = (index + 1) * window;

    if (progress >= start && progress < end) {
      final double local = (progress - start) / window;
      // Smooth bell curve wave: peaks at 1.0 in the middle
      return math.sin(local * math.pi);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final double baseOpacity = 0.65 * widget.scrollFade;

    // Completely remove from the widget tree once faded out so it is invisible in the Intro view
    if (baseOpacity <= 0.005) {
      return const SizedBox.shrink();
    }

    final double fontSize = widget.isMobile
        ? (widget.screenWidth * 0.38).clamp(100.0, 190.0)
        : (widget.screenWidth * 0.30).clamp(180.0, 360.0);
    final double letterGap = widget.isMobile ? 24.0 : 58.0;

    // Subtle outward horizontal drift as the user starts scrolling (sketchbook curtain effect)
    final double scrollSpread =
        (1.0 - widget.scrollFade) * (widget.isMobile ? 8.0 : 20.0);

    return IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _cycleController,
              builder: (context, _) {
                final double cycleProgress = _cycleController.value;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _letters.length; i++) ...[
                      if (i > 0) SizedBox(width: letterGap + scrollSpread),
                      _HelloLetterItem(
                        index: i,
                        character: _letters[i],
                        fontSize: fontSize,
                        baseOpacity: baseOpacity,
                        scrollFade: widget.scrollFade,
                        autoProgress: _computeLetterAutoActivation(
                          i,
                          cycleProgress,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual animated letter inside [HelloWatermarkWidget] with auto-cycle support (no hover).
class _HelloLetterItem extends StatelessWidget {
  final int index;
  final String character;
  final double fontSize;
  final double baseOpacity;
  final double scrollFade;
  final double autoProgress;

  const _HelloLetterItem({
    required this.index,
    required this.character,
    required this.fontSize,
    required this.baseOpacity,
    required this.scrollFade,
    required this.autoProgress,
  });

  @override
  Widget build(BuildContext context) {
    return _buildLetterVisual(hoverValue: autoProgress);
  }

  /// Builds the visual representation of a single letter given the current [hoverValue].
  Widget _buildLetterVisual({required double hoverValue}) {
    final double clampedHover = hoverValue.clamp(0.0, 1.0);
    final double scale = 1.0 + (0.14 * clampedHover);
    final double liftY = -14.0 * clampedHover;
    final double tiltAngle = (index.isEven ? -0.03 : 0.03) * clampedHover;

    // Idle state: High-contrast charcoal with clear visibility
    final Color idleColor = AppColors.textMain.withValues(
      alpha: (0.60 * scrollFade).clamp(0.0, 1.0),
    );
    // Active auto card state: Solid deep black letter
    const Color activeColor = Color(0xFF000000);
    final Color letterColor =
        Color.lerp(idleColor, activeColor, clampedHover) ?? idleColor;

    return Transform.translate(
      offset: Offset(0.0, liftY),
      child: Transform.rotate(
        angle: tiltAngle,
        child: Transform.scale(
          scale: scale,
          child: CustomPaint(
            painter: _HelloLetterHoverPainter(
              hoverProgress: clampedHover,
              seed: index * 17 + 11,
              idleOpacity: scrollFade,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                character,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  color: letterColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for each individual letter of "HELLO".
///
/// Draws NO outline box around the letter. When active, it draws a gentle hand-drawn
/// sketch accent underline and subtle radiating burst marks.
class _HelloLetterHoverPainter extends CustomPainter {
  final double hoverProgress;
  final int seed;
  final double idleOpacity;

  const _HelloLetterHoverPainter({
    required this.hoverProgress,
    required this.seed,
    required this.idleOpacity,
  });

  double _noise(int step, int s) {
    return math.sin(step * 2.39 + s * 1.61) * 0.65 +
        math.cos(step * 4.11 - s * 0.87) * 0.35;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0 || idleOpacity <= 0.01) return;
    if (hoverProgress <= 0.01) return;

    final double w = size.width;
    final double h = size.height;

    // Hand-drawn sketch accent underline when letter activates (no outline box)
    final Paint accentPaint = Paint()
      ..color = AppColors.primary.withValues(
        alpha: 0.80 * hoverProgress * idleOpacity,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final Path hoverUnderline = Path()
      ..moveTo(w * 0.12, h * 0.94)
      ..quadraticBezierTo(
        w * 0.50,
        h * 0.94 + 4.0 * _noise(3, seed),
        w * 0.12 + (w * 0.76 * hoverProgress),
        h * 0.94,
      );
    canvas.drawPath(hoverUnderline, accentPaint);

    // Subtle sketch burst spark above the active letter
    final double burstLen = 12.0 * hoverProgress;
    for (int i = -1; i <= 1; i += 2) {
      final double bx = w * 0.5 + (i * w * 0.20);
      final double by = h * 0.06;
      canvas.drawLine(
        Offset(bx, by),
        Offset(bx + i * 5.0 * hoverProgress, by - burstLen),
        accentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HelloLetterHoverPainter oldDelegate) {
    return oldDelegate.hoverProgress != hoverProgress ||
        oldDelegate.seed != seed ||
        oldDelegate.idleOpacity != idleOpacity;
  }
}
