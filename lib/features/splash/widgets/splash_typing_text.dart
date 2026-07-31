import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import '../../../../core/themes/theme.dart';
import '../splash_controller.dart';

/// SplashTypingText — Senior UX-level Neomorphic knockout splash.
/// Large, bold headline in a single line with neomorphic text shadows,
/// followed by a refined subtitle with wide letter-spacing and a decorative divider.
class SplashTypingText extends StatefulWidget {
  const SplashTypingText({super.key});

  @override
  State<SplashTypingText> createState() => _SplashTypingTextState();
}

class _SplashTypingTextState extends State<SplashTypingText>
    with SingleTickerProviderStateMixin {
  bool _headlineDone = false;
  late final AnimationController _dividerController;
  late final Animation<double> _dividerWidth;

  @override
  void initState() {
    super.initState();
    _dividerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _dividerWidth = CurvedAnimation(
      parent: _dividerController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _dividerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.find<SplashController>();

    // ── Large responsive font sizes for maximum visual impact ─────────
    final double headlineFontSize;
    final double subtitleFontSize;

    if (screenWidth < 400) {
      headlineFontSize = 28.0;
      subtitleFontSize = 12.0;
    } else if (screenWidth < 600) {
      headlineFontSize = 36.0;
      subtitleFontSize = 14.0;
    } else if (screenWidth < 900) {
      headlineFontSize = 48.0;
      subtitleFontSize = 16.0;
    } else if (screenWidth < 1200) {
      headlineFontSize = 56.0;
      subtitleFontSize = 18.0;
    } else {
      headlineFontSize = 64.0;
      subtitleFontSize = 20.0;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth < 600 ? 20 : 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── 1. PRIMARY HEADLINE — big, bold, neomorphic ─────────────────
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: SizedBox(
              height: headlineFontSize * 1.8,
              child: Center(
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  isRepeatingAnimation: false,
                  onFinished: () {
                    if (mounted) {
                      setState(() => _headlineDone = true);
                      _dividerController.forward();
                    }
                  },
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'I BUILD DIGITAL PRODUCTS',
                      speed: const Duration(milliseconds: 65),
                      textAlign: TextAlign.center,
                      curve: Curves.easeOut,
                      textStyle: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: headlineFontSize,
                        fontWeight: FontWeight.w900,
                        color: AppColors.background,
                        letterSpacing: screenWidth < 600 ? 1.0 : 3.0,
                        height: 1.1,
                        // Neomorphic text shadow: embossed look on orange
                        shadows: [
                          // Dark shadow (bottom-right) — creates depth
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            offset: const Offset(3, 3),
                            blurRadius: 6,
                          ),
                          // Light highlight (top-left) — the neomorphic "lift"
                          Shadow(
                            color: Colors.white.withValues(alpha: 0.15),
                            offset: const Offset(-1, -1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 2. ANIMATED DIVIDER LINE ────────────────────────────────────
          const SizedBox(height: 20),
          SizeTransition(
            sizeFactor: _dividerWidth,
            axis: Axis.horizontal,
            alignment: Alignment.center,
            child: Container(
              width: screenWidth < 600 ? 60 : 100,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(1, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── 3. SUBTITLE — refined, wide-spaced, elegant ────────────────
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: SizedBox(
              height: subtitleFontSize * 2.4,
              child: Center(
                child: _headlineDone
                    ? AnimatedTextKit(
                        totalRepeatCount: 1,
                        isRepeatingAnimation: false,
                        onFinished: () {
                          controller.onTypingFinished();
                        },
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'T H A T   S O L V E   R E A L   P R O B L E M S',
                            speed: const Duration(milliseconds: 40),
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.w300,
                              color: AppColors.background.withValues(alpha: 0.7),
                              letterSpacing: 4.0,
                              // Subtle neomorphic emboss on the subtitle too
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  offset: const Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
