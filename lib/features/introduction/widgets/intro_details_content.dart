import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

import '../../../core/themes/theme.dart';
import '../../../services/resume_downloader.dart';
import '../../../widgets/button/sketch_button.dart';
import '../../../widgets/sketch_painter.dart';

/// Reusable widget that renders the personal introduction details:
/// - Normal "I am" lead-in text
/// - Large responsive "FAZAL-E-HAQ" heading with a hand-drawn pencil divider
/// - Animated repeating "Flutter Developer" role title with blinking pencil cursor and wavy ink underline
/// - Bio summary paragraph
/// - Hand-drawn brutalist stat bar: 1 · 3+ · 1.1k
/// - Call-to-action [ButtonWidget] ("Download Resume")
class IntroDetailsContent extends StatelessWidget {
  final double nameFontSize;
  final double roleFontSize;
  final double bodyFontSize;
  final CrossAxisAlignment alignment;
  final TextAlign textAlign;
  final bool isActive;

  const IntroDetailsContent({
    super.key,
    required this.nameFontSize,
    required this.roleFontSize,
    required this.bodyFontSize,
    required this.alignment,
    required this.textAlign,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCentered = textAlign == TextAlign.center;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Clean, normal "I am" lead-in text
        Text(
          'I am',
          style: TextStyle(
            fontSize: roleFontSize * 0.85,
            color: AppColors.textMain.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 4),

        // 2. Large, responsive name heading
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: isCentered ? Alignment.center : Alignment.centerLeft,
          child: Text(
            'FAZAL-E-HAQ',
            style: TextStyle(
              fontSize: nameFontSize,
              fontWeight: FontWeight.w900,
              color: AppColors.textMain,
              height: 1.05,
              letterSpacing: 1.2,
              fontFamily: 'Patrick Hand',
              shadows: [
                Shadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  offset: const Offset(3.5, 3.5),
                ),
              ],
            ),
            textAlign: textAlign,
          ),
        ),
        const SizedBox(height: 6),

        // 3. Hand-drawn wobbly pencil underline
        SketchDivider(
          width: nameFontSize * 3.2,
          height: 8,
          strokeWidth: 2.4,
          seed: 14,
        ),
        const SizedBox(height: 8),

        // 4. Role title with letter-by-letter handwriting animation ("Flutter Developer", "Software Architect", "Mobile & Web Engineer", "Cross-Platform Specialist")
        _AnimatedRoleTitle(
          fontSize: roleFontSize,
          textAlign: textAlign,
          isActive: isActive,
        ),
        const SizedBox(height: 12),

        // 5. Short bio description with slow typewriter typing animation and enlarged 'W'
        _TypewriterSentence(
          text:
              'Who turns your ideas into fast, reliable mobile apps and websites that people genuinely love to use.',
          fontSize: bodyFontSize,
          textAlign: textAlign,
          isActive: isActive,
        ),
        const SizedBox(height: 18),

        // 6. Brutalist stat bar: 1 · 3+ · 1.1k
        _IntroBrutalistStatBar(isCentered: isCentered),
        const SizedBox(height: 22),

        // 7. Interactive sketch CTA button ("Download Resume")
        ButtonWidget(
          id: 'intro_resume_btn',
          text: const Text('Download Resume'),
          icon: const Icon(
            CupertinoIcons.arrow_down_to_line,
            size: 18,
            color: AppColors.textMain,
          ),
          onPressed: () {
            downloadResume();
          },
        ),
      ],
    );
  }
}

/// Animated role title hand-writing letter-by-letter through professional titles
/// ("Flutter Developer", "Software Architect", "Mobile & Web Engineer", "Cross-Platform Specialist")
/// with an organic handwriting cadence, live pencil lead tip cursor, and dynamic sketch wavy underline.
class _AnimatedRoleTitle extends StatefulWidget {
  final double fontSize;
  final TextAlign textAlign;
  final bool isActive;

  const _AnimatedRoleTitle({
    required this.fontSize,
    required this.textAlign,
    this.isActive = true,
  });

  @override
  State<_AnimatedRoleTitle> createState() => _AnimatedRoleTitleState();
}

class _AnimatedRoleTitleState extends State<_AnimatedRoleTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  Timer? _stepTimer;

  static const List<String> _roles = [
    'Flutter Developer',
    'Software Architect',
    'Mobile & Web Engineer',
    'Cross-Platform Specialist',
  ];

  int _roleIndex = 0;
  late int _charIndex;
  bool _isErasing = false;
  bool _isPausedAtFull = true;

  @override
  void initState() {
    super.initState();
    // Start with the primary role fully presented to eliminate layout jump and assure instant visual readiness
    _charIndex = _roles[0].length;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // Initial reading dwell time before starting the organic handwriting cycle
    if (widget.isActive) {
      _stepTimer = Timer(const Duration(milliseconds: 2600), _beginErasing);
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedRoleTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      if (_stepTimer == null || !_stepTimer!.isActive) {
        _stepTimer = Timer(const Duration(milliseconds: 1000), _beginErasing);
      }
    }
  }

  void _beginErasing() {
    if (!mounted) return;
    setState(() {
      _isPausedAtFull = false;
      _isErasing = true;
    });
    _stepTimer = Timer(const Duration(milliseconds: 30), _handwritingLoop);
  }

  void _handwritingLoop() {
    if (!mounted) return;
    final String currentRole = _roles[_roleIndex];

    if (_isErasing) {
      if (_charIndex > 0) {
        setState(() {
          _charIndex--;
        });
        _stepTimer = Timer(const Duration(milliseconds: 28), _handwritingLoop);
      } else {
        // Erased to blank, cycle to the next professional role
        _isErasing = false;
        _roleIndex = (_roleIndex + 1) % _roles.length;
        setState(() {});
        // Organic pause before penning the next role
        _stepTimer = Timer(const Duration(milliseconds: 260), _handwritingLoop);
      }
    } else {
      if (_charIndex < currentRole.length) {
        setState(() {
          _charIndex++;
        });
        final String currentChar = currentRole[_charIndex - 1];
        // Human handwriting cadence:
        // - Spaces take longer (hand repositioning on paper): ~140ms
        // - Capital letters require more pen strokes: ~95ms
        // - Lowercase letters flow naturally: ~65-85ms
        int delay;
        if (currentChar == ' ') {
          delay = 140;
        } else if (currentChar == currentChar.toUpperCase() &&
            currentChar != currentChar.toLowerCase()) {
          delay = 95;
        } else {
          delay = 68 + (_charIndex % 3) * 8;
        }
        _stepTimer = Timer(Duration(milliseconds: delay), _handwritingLoop);
      } else {
        // Completed writing full role!
        setState(() {
          _isPausedAtFull = true;
        });
        // Dwell pause so the reader can comfortably read the role
        _stepTimer = Timer(const Duration(milliseconds: 2400), _beginErasing);
      }
    }
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCentered = widget.textAlign == TextAlign.center;
    final String currentRole = _roles[_roleIndex];
    final String visibleText =
        currentRole.substring(0, _charIndex.clamp(0, currentRole.length));

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        final double t = _pulseController.value;
        // Subtle graphite ink sheen
        final Color inkColor = Color.lerp(
              AppColors.primary,
              AppColors.textMain,
              (math.sin(t * 2.0 * math.pi) * 0.5 + 0.5) * 0.25,
            ) ??
            AppColors.primary;

        // Cursor breathing pulse while resting at full text
        final double cursorPulse = _isPausedAtFull
            ? (math.sin(t * 4.0 * math.pi) > 0.0 ? 1.0 : 0.20)
            : 1.0;

        // Active writing micro-vibration
        final double dipOffset = (!_isPausedAtFull && !_isErasing)
            ? (math.sin(_charIndex * 2.4) * 1.2)
            : 0.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isCentered
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  visibleText,
                  key: const ValueKey<String>('role_title_text'),
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: inkColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    fontFamily: 'Patrick Hand',
                    height: 1.1,
                  ),
                  textAlign: widget.textAlign,
                ),
                const SizedBox(width: 4),
                // Hand-Drawn Slanted Pencil Lead Cursor
                Transform.translate(
                  offset: Offset(0, dipOffset),
                  child: Opacity(
                    opacity: cursorPulse,
                    child: _PencilNibCursor(
                      height: widget.fontSize * 0.88,
                      isErasing: _isErasing,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            // Hand-drawn sketch wavy underline that organically tracks handwriting progress
            CustomPaint(
              size: Size(
                math.max(
                  widget.fontSize * 1.5,
                  widget.fontSize * (0.60 * _charIndex),
                ),
                6,
              ),
              painter: _RoleUnderlinePainter(progress: t),
            ),
          ],
        );
      },
    );
  }
}

/// Miniature hand-drawn pencil cursor that sits at the writing tip.
/// Slanted at a natural writer's angle (-0.20 rad) while writing with a graphite lead tip,
/// and rotates (-0.42 rad) showing the pink eraser ferrule while erasing.
class _PencilNibCursor extends StatelessWidget {
  final double height;
  final bool isErasing;

  const _PencilNibCursor({
    required this.height,
    required this.isErasing,
  });

  @override
  Widget build(BuildContext context) {
    final double width = height * 0.48;

    return Transform.rotate(
      angle: isErasing ? -0.42 : -0.20,
      child: CustomPaint(
        size: Size(width, height),
        painter: _PencilNibPainter(isErasing: isErasing),
      ),
    );
  }
}

class _PencilNibPainter extends CustomPainter {
  final bool isErasing;

  const _PencilNibPainter({required this.isErasing});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Charcoal ink outline matching Hand-Drawn Brutalism sketch guidelines
    final Paint strokePaint = Paint()
      ..color = AppColors.textMain
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.35
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Paper background fill matching sketchbook paper (#FDF0D5)
    final Paint paperFill = Paint()
      ..color = AppColors.background
      ..style = PaintingStyle.fill;

    // Soft charcoal wash / graphite hatch fill for metal collar shading
    final Paint graphiteShade = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;

    // Fine detail stroke for hand-drawn sketch texture lines
    final Paint detailStroke = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.95
      ..strokeCap = StrokeCap.round;

    if (isErasing) {
      // 1. Metal Ferrule Collar holding eraser (soft graphite shade with sketch crimp lines)
      final Rect ferruleRect =
          Rect.fromLTWH(w * 0.15, h * 0.35, w * 0.70, h * 0.25);
      canvas.drawRect(ferruleRect, graphiteShade);
      canvas.drawRect(ferruleRect, strokePaint);

      // Sketched crimp lines across the ferrule
      canvas.drawLine(
        Offset(w * 0.15, h * 0.43),
        Offset(w * 0.85, h * 0.43),
        detailStroke,
      );
      canvas.drawLine(
        Offset(w * 0.15, h * 0.51),
        Offset(w * 0.85, h * 0.51),
        detailStroke,
      );

      // 2. Hand-Drawn Eraser Block (Pure sketchbook paper tone with charcoal outline)
      final RRect eraserRRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.15, h * 0.60, w * 0.70, h * 0.35),
        bottomLeft: const Radius.circular(3),
        bottomRight: const Radius.circular(3),
      );
      canvas.drawRRect(eraserRRect, paperFill);
      canvas.drawRRect(eraserRRect, strokePaint);

      // Subtle diagonal sketch marks on the eraser rubber
      canvas.drawLine(
        Offset(w * 0.28, h * 0.70),
        Offset(w * 0.45, h * 0.87),
        detailStroke,
      );
      canvas.drawLine(
        Offset(w * 0.52, h * 0.70),
        Offset(w * 0.69, h * 0.87),
        detailStroke,
      );
      return;
    }

    // 1. Pencil Barrel (Warm sketchbook paper with charcoal facet sketch lines)
    final Path barrelPath = Path()
      ..moveTo(w * 0.12, 0)
      ..lineTo(w * 0.88, 0)
      ..lineTo(w * 0.88, h * 0.52)
      ..lineTo(w * 0.12, h * 0.52)
      ..close();
    canvas.drawPath(barrelPath, paperFill);
    canvas.drawPath(barrelPath, strokePaint);

    // Longitudinal facet sketch lines showing hexagonal pencil barrel
    canvas.drawLine(
      Offset(w * 0.37, 0),
      Offset(w * 0.37, h * 0.52),
      detailStroke,
    );
    canvas.drawLine(
      Offset(w * 0.63, 0),
      Offset(w * 0.63, h * 0.52),
      detailStroke,
    );

    // 2. Sharpened Wood Cone (Paper tone with charcoal outline and carved scallop)
    final Path woodPath = Path()
      ..moveTo(w * 0.12, h * 0.52)
      ..lineTo(w * 0.88, h * 0.52)
      ..lineTo(w * 0.50, h * 0.98)
      ..close();
    canvas.drawPath(woodPath, paperFill);
    canvas.drawPath(woodPath, strokePaint);

    // Subtle hand-carved wood scallop curve
    final Path scallopPath = Path()
      ..moveTo(w * 0.22, h * 0.52)
      ..quadraticBezierTo(w * 0.50, h * 0.62, w * 0.78, h * 0.52);
    canvas.drawPath(scallopPath, detailStroke);

    // 3. Graphite Lead Tip (Pure AppColors.primary charcoal black)
    final Paint leadPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final Path leadPath = Path()
      ..moveTo(w * 0.38, h * 0.80)
      ..lineTo(w * 0.62, h * 0.80)
      ..lineTo(w * 0.50, h * 0.98)
      ..close();
    canvas.drawPath(leadPath, leadPaint);
    canvas.drawPath(leadPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _PencilNibPainter oldDelegate) =>
      oldDelegate.isErasing != isErasing;
}

/// Custom painter for an animated hand-drawn wavy underline accent beneath the role.
class _RoleUnderlinePainter extends CustomPainter {
  final double progress;

  const _RoleUnderlinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final Paint paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.70)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0, h * 0.5);
    const int segments = 8;
    for (int i = 1; i <= segments; i++) {
      final double x = (w / segments) * i;
      final double wave =
          math.sin((i * 1.1) + (progress * 2 * math.pi)) * (h * 0.40);
      path.lineTo(x, h * 0.5 + wave);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoleUnderlinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Slow typewriter animation typing the bio sentence in with an enlarged initial 'W'.
class _TypewriterSentence extends StatefulWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final bool isActive;

  const _TypewriterSentence({
    required this.text,
    required this.fontSize,
    required this.textAlign,
    this.isActive = true,
  });

  @override
  State<_TypewriterSentence> createState() => _TypewriterSentenceState();
}

class _TypewriterSentenceState extends State<_TypewriterSentence>
    with SingleTickerProviderStateMixin {
  late final AnimationController _typeController;

  @override
  void initState() {
    super.initState();
    _typeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800), // Calm, slow typing tempo
    );
    if (widget.isActive) {
      _typeController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _TypewriterSentence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive &&
        !_typeController.isCompleted &&
        !_typeController.isAnimating) {
      _typeController.forward();
    }
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String fullText = widget.text;

    return AnimatedBuilder(
      animation: _typeController,
      builder: (context, _) {
        final double progress = _typeController.value;
        final int charCount = _typeController.isCompleted
            ? fullText.length
            : (progress * fullText.length).round();

        final String visible =
            fullText.substring(0, charCount.clamp(0, fullText.length));

        if (visible.isEmpty) {
          return SizedBox(height: widget.fontSize * 1.5);
        }

        final String firstChar = visible[0];
        final String rest = visible.length > 1 ? visible.substring(1) : '';

        return Text.rich(
          TextSpan(
            children: [
              // Noticeably larger, bold capital 'W'
              TextSpan(
                text: firstChar,
                style: TextStyle(
                  fontSize: (widget.fontSize * 1.45).roundToDouble(),
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  fontFamily: 'Patrick Hand',
                  height: 1.0,
                ),
              ),
              if (rest.isNotEmpty)
                TextSpan(
                  text: rest,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMain.withValues(alpha: 0.82),
                    fontFamily: 'Patrick Hand',
                    height: 1.5,
                  ),
                ),
            ],
          ),
          textAlign: widget.textAlign,
        );
      },
    );
  }
}

/// Clean Brutalist stat bar displaying: 1 · 3+ · 1.1k without an outline
class _IntroBrutalistStatBar extends StatelessWidget {
  final bool isCentered;

  const _IntroBrutalistStatBar({required this.isCentered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          _buildStatColumn('1', 'Year Exp.'),
          _buildDivider(),
          _buildStatColumn('3+', 'Projects'),
          _buildDivider(),
          _buildStatColumn('1.1k', 'Followers'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String number, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.textMain,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: 1.6,
        height: 20,
        decoration: BoxDecoration(
          color: AppColors.textMain.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
