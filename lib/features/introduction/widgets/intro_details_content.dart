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
/// - Hand-drawn brutalist stat bar: 1 | 3+ | 1.1k
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

        // 4. Role title with animated cycling roles ("Flutter Developer", "Mobile Engineer", "Dart Specialist")
        _AnimatedRoleTitle(
          fontSize: roleFontSize,
          textAlign: textAlign,
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

        // 6. Brutalist stat bar: 1 | 3+ | 1.1k
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

/// Animated role title cycling through "Flutter Developer" and other skills repeatedly.
class _AnimatedRoleTitle extends StatefulWidget {
  final double fontSize;
  final TextAlign textAlign;

  const _AnimatedRoleTitle({
    required this.fontSize,
    required this.textAlign,
  });

  @override
  State<_AnimatedRoleTitle> createState() => _AnimatedRoleTitleState();
}

class _AnimatedRoleTitleState extends State<_AnimatedRoleTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _underlineController;
  Timer? _cycleTimer;

  static const List<String> _roles = [
    'Flutter Developer',
    'Mobile Engineer',
    'Dart Specialist',
  ];

  int _currentRoleIndex = 0;

  @override
  void initState() {
    super.initState();
    _underlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // Repeat cycling every 2800ms
    _cycleTimer = Timer.periodic(const Duration(milliseconds: 2800), (_) {
      if (mounted) {
        setState(() {
          _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _underlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCentered = widget.textAlign == TextAlign.center;
    final String currentText = _roles[_currentRoleIndex];

    return AnimatedBuilder(
      animation: _underlineController,
      builder: (context, _) {
        final double t = _underlineController.value;
        // Blinking cursor opacity: blinks periodically
        final double cursorOpacity =
            (math.sin(t * 4.0 * math.pi) > 0.0) ? 1.0 : 0.10;
        // Subtle graphite ink sheen
        final Color inkColor = Color.lerp(
              AppColors.primary,
              AppColors.textMain,
              (math.sin(t * 2.0 * math.pi) * 0.5 + 0.5) * 0.25,
            ) ??
            AppColors.primary;

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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 380),
                  transitionBuilder: (child, animation) {
                    final slideIn = Tween<Offset>(
                      begin: const Offset(0.0, 0.35),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ));
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: slideIn,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    currentText,
                    key: ValueKey<String>(currentText),
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
                ),
                const SizedBox(width: 4),
                // Blinking hand-drawn pencil cursor
                Opacity(
                  opacity: cursorOpacity,
                  child: Container(
                    width: 3.0,
                    height: widget.fontSize * 0.82,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            // Hand-drawn sketch wavy underline with animated ink undulation
            CustomPaint(
              size: Size(widget.fontSize * 5.6, 6),
              painter: _RoleUnderlinePainter(progress: t),
            ),
          ],
        );
      },
    );
  }
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

/// Clean Brutalist stat bar displaying: 1 | 3+ | 1.1k without an outline
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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '|',
        style: TextStyle(
          fontFamily: 'Patrick Hand',
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: AppColors.textMain.withValues(alpha: 0.30),
        ),
      ),
    );
  }
}
