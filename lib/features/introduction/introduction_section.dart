import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../app_shell/scroll_coordinator_controller.dart';
import 'introduction_controller.dart';
import 'widgets/hello_watermark_widget.dart';
import 'widgets/intro_details_content.dart';

/// The Hero Introduction Section of the portfolio.
///
/// Architecture & State Management:
/// - Uses [IntroductionController] (GetX) to manage scroll progress and per-letter hover states.
/// - Composes reusable, single-responsibility widgets:
///   - [HelloWatermarkWidget]: Interactive auto-cycling "HELLO" watermark letters that morph letter-by-letter.
///   - [IntroDetailsContent]: Personal bio ("I am", "FAZAL-E-HAQ", "Flutter Developer", CTA buttons).
///   - [_ScrollDownIndicator]: Bouncing, hand-sketched scroll-down prompt with arrow indicator.
/// - Uses a smooth, flat **Sketchbook Page Glide** transition (zero 3D skewing/tilting)
///   that keeps all hand-drawn typography and artwork crisp, level, and responsive across
///   Mobile, Tablet, and Desktop viewports.
class Introduction extends StatefulWidget {
  final ScrollController? scrollController;

  const Introduction({super.key, this.scrollController});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  late final IntroductionController _introController;

  /// Natural aspect ratio of `assets/Images/my-image/my-pic.webp` (1386w x 1135h).
  static const double _imageAspectRatio = 1386.0 / 1135.0;

  @override
  void initState() {
    super.initState();
    _introController = Get.isRegistered<IntroductionController>()
        ? Get.find<IntroductionController>()
        : Get.put(IntroductionController());
  }

  /// Resolves the active [ScrollController] from widget props or [ScrollCoordinatorController].
  ScrollController? _resolveScrollController() {
    if (widget.scrollController != null) {
      return widget.scrollController;
    }
    if (Get.isRegistered<ScrollCoordinatorController>()) {
      return Get.find<ScrollCoordinatorController>().scrollController;
    }
    return null;
  }

  void _onScrollDownTapped(double transitionDistance) {
    final effectiveScrollController = _resolveScrollController();
    if (effectiveScrollController != null &&
        effectiveScrollController.hasClients) {
      if (effectiveScrollController.offset < transitionDistance * 0.7) {
        effectiveScrollController.animateTo(
          transitionDistance,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      } else if (Get.isRegistered<ScrollCoordinatorController>()) {
        Get.find<ScrollCoordinatorController>().scrollToSection(1);
      }
    } else if (Get.isRegistered<ScrollCoordinatorController>()) {
      Get.find<ScrollCoordinatorController>().scrollToSection(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController? effectiveScrollController =
        _resolveScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double screenWidth = MediaQuery.of(context).size.width;
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        // Scroll distance over which the hero transitions from the initial "HELLO" view
        // into the full Intro layout before scrolling naturally to the next section.
        final double transitionDistance = isMobile ? 480.0 : 550.0;
        final double heroViewportHeight = isMobile
            ? (screenHeight * 0.95)
            : screenHeight;
        final double totalSectionHeight =
            heroViewportHeight + transitionDistance;

        Widget buildReactiveStage(double scrollOffset) {
          // Keep GetX controller in sync
          _introController.updateScrollProgress(
            scrollOffset,
            transitionDistance,
          );
          final double pinnedY = scrollOffset.clamp(0.0, transitionDistance);
          final double progress = (scrollOffset / transitionDistance).clamp(
            0.0,
            1.0,
          );
          final double helloFade = _introController.computeHelloFade(progress);
          final double portraitGlide = _introController.computePortraitGlide(
            progress,
          );
          final double introReveal = _introController.computeIntroReveal(
            progress,
          );

          return SizedBox(
            height: totalSectionHeight,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: pinnedY,
                  left: 0,
                  right: 0,
                  height: heroViewportHeight,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1680),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile
                              ? 16.0
                              : (isTablet
                                    ? 24.0
                                    : (screenWidth > 1400 ? 48.0 : 32.0)),
                          vertical: isMobile ? 12.0 : 24.0,
                        ),
                        child: LayoutBuilder(
                          builder: (context, heroBox) {
                            final double heroWidth = heroBox.maxWidth;
                            final double heroHeight = heroBox.maxHeight;

                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // 1. Subtle hand-drawn sketchbook orbital ring on first view
                                if (helloFade > 0.01)
                                  IgnorePointer(
                                    child: Opacity(
                                      opacity: helloFade,
                                      child: SizedBox(
                                        width: heroWidth,
                                        height: heroHeight,
                                        child: CustomPaint(
                                          painter: _SketchbookHaloPainter(
                                            isMobile: isMobile,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                // 2. Interactive "HELLO" watermark (auto-cycling letter by letter)
                                HelloWatermarkWidget(
                                  screenWidth: screenWidth,
                                  isMobile: isMobile,
                                  scrollFade: helloFade,
                                ),

                                // 3. Responsive Sketchbook Hero Stage (Bigger Portrait, Desktop/Tablet or Mobile)
                                SizedBox(
                                  width: heroWidth,
                                  height: heroHeight,
                                  child: heroWidth >= 880
                                      ? _DesktopSketchHeroStage(
                                          heroWidth: heroWidth,
                                          heroHeight: heroHeight,
                                          portraitGlide: portraitGlide,
                                          introReveal: introReveal,
                                          imageAspectRatio: _imageAspectRatio,
                                        )
                                      : _MobileSketchHeroStage(
                                          heroWidth: heroWidth,
                                          heroHeight: heroHeight,
                                          portraitGlide: portraitGlide,
                                          introReveal: introReveal,
                                          imageAspectRatio: _imageAspectRatio,
                                        ),
                                ),

                                // 4. Hand-drawn bouncing "SCROLL DOWN" prompt at the bottom
                                if (helloFade > 0.05)
                                  Positioned(
                                    bottom: isMobile ? 12.0 : 22.0,
                                    child: _ScrollDownIndicator(
                                      opacity: (1.0 - (progress * 3.0)).clamp(
                                        0.0,
                                        1.0,
                                      ),
                                      isMobile: isMobile,
                                      onTap: () => _onScrollDownTapped(
                                        transitionDistance,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (effectiveScrollController != null) {
          return AnimatedBuilder(
            animation: effectiveScrollController,
            builder: (context, _) {
              final double offset = effectiveScrollController.hasClients
                  ? effectiveScrollController.offset
                  : 0.0;
              return buildReactiveStage(offset);
            },
          );
        }

        return buildReactiveStage(0.0);
      },
    );
  }
}

/// Desktop & Tablet Hero layout using a smooth, flat Sketchbook Glide with larger picture.
class _DesktopSketchHeroStage extends StatelessWidget {
  final double heroWidth;
  final double heroHeight;
  final double portraitGlide;
  final double introReveal;
  final double imageAspectRatio;

  const _DesktopSketchHeroStage({
    required this.heroWidth,
    required this.heroHeight,
    required this.portraitGlide,
    required this.introReveal,
    required this.imageAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final double colGap = (heroWidth * 0.04).clamp(32.0, 72.0);
    final double availableWidth = heroWidth - colGap;

    // Left column for personal intro text
    final double leftColWidth = (availableWidth * 0.52).clamp(400.0, 840.0);
    final double rightColWidth = availableWidth - leftColWidth;

    // Initial Portrait Geometry (Centered with comfortable spacing from bottom indicator)
    final double maxPossibleH = (heroHeight * 0.84).clamp(460.0, 850.0);
    final double naturalW = maxPossibleH * imageAspectRatio;
    final double startW = naturalW.clamp(380.0, heroWidth * 0.94);
    final double startH = startW / imageAspectRatio;
    final double startX = (heroWidth - startW) / 2.0;
    final double startY = ((heroHeight - startH) / 2.0) - 20.0;

    // Resting Portrait Geometry (Fitted neatly in right column with zero overflow)
    final double endW = (rightColWidth * 1.15).clamp(320.0, 720.0);
    final double endH = endW / imageAspectRatio;
    final double endX = leftColWidth + colGap + ((rightColWidth - endW) / 2.0);
    final double endY = (heroHeight - endH) / 2.0;

    // Smooth 2D interpolation (no 3D skewing)
    final double currentW = startW + (endW - startW) * portraitGlide;
    final double currentH = startH + (endH - startH) * portraitGlide;
    final double currentX = startX + (endX - startX) * portraitGlide;
    final double currentY = startY + (endY - startY) * portraitGlide;

    // Gentle sketchbook slide-up & scale for the Intro text on the left
    final double introSlideY = (1.0 - introReveal) * 32.0;
    final double introScale = 0.96 + (0.04 * introReveal);

    // Responsive typography sizes - noticeably bigger name heading
    final double nameFontSize = leftColWidth < 600
        ? 52.0
        : (leftColWidth < 740 ? 64.0 : (leftColWidth < 880 ? 76.0 : 86.0));
    final double roleFontSize = (nameFontSize * 0.40).clamp(22.0, 32.0);
    final double bodyFontSize = (nameFontSize * 0.22).clamp(14.0, 17.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Left Column: Personal Intro Content
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: leftColWidth,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IgnorePointer(
              ignoring: introReveal < 0.6,
              child: Opacity(
                opacity: introReveal,
                child: Transform.translate(
                  offset: Offset(0.0, introSlideY),
                  child: Transform.scale(
                    scale: introScale,
                    alignment: Alignment.centerLeft,
                    child: RepaintBoundary(
                      child: IntroDetailsContent(
                        nameFontSize: nameFontSize,
                        roleFontSize: roleFontSize,
                        bodyFontSize: bodyFontSize,
                        alignment: CrossAxisAlignment.start,
                        textAlign: TextAlign.left,
                        isActive: introReveal > 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Center -> Right Column: Clean Portrait Image with Soft Gradient Opacity at Bottom
        Positioned(
          left: currentX,
          top: currentY,
          width: currentW,
          height: currentH,
          child: RepaintBoundary(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.68, 1.0],
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0x00FFFFFF),
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/Images/my-image/my-pic.webp',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                cacheWidth: 1200,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Mobile Hero layout using a smooth, flat Sketchbook Glide with larger picture.
class _MobileSketchHeroStage extends StatelessWidget {
  final double heroWidth;
  final double heroHeight;
  final double portraitGlide;
  final double introReveal;
  final double imageAspectRatio;

  const _MobileSketchHeroStage({
    required this.heroWidth,
    required this.heroHeight,
    required this.portraitGlide,
    required this.introReveal,
    required this.imageAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    // Starting portrait on mobile with clean breathing room above scroll down
    final double startW = (heroWidth * 0.94).clamp(270.0, 480.0);
    final double startH = startW / imageAspectRatio;
    final double startX = (heroWidth - startW) / 2.0;
    final double startY = (heroHeight * 0.32) - (startH / 2.0);

    // Resting portrait on mobile scaled neatly at the top
    final double endW = (heroWidth * 0.65).clamp(200.0, 300.0);
    final double endH = endW / imageAspectRatio;
    final double endX = (heroWidth - endW) / 2.0;
    final double endY = heroHeight * 0.02;

    final double currentW = startW + (endW - startW) * portraitGlide;
    final double currentH = startH + (endH - startH) * portraitGlide;
    final double currentX = startX + (endX - startX) * portraitGlide;
    final double currentY = startY + (endY - startY) * portraitGlide;

    final double introSlideY = (1.0 - introReveal) * 24.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Portrait gliding smoothly from center to top with soft gradient opacity at bottom
        Positioned(
          left: currentX,
          top: currentY,
          width: currentW,
          height: currentH,
          child: RepaintBoundary(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.68, 1.0],
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0x00FFFFFF),
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/Images/my-image/my-pic.webp',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                cacheWidth: 800,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),

        // Personal Intro Content sliding up below the resting portrait
        Positioned(
          left: 0,
          right: 0,
          bottom: 10.0,
          child: IgnorePointer(
            ignoring: introReveal < 0.6,
            child: Opacity(
              opacity: introReveal,
              child: Transform.translate(
                offset: Offset(0.0, introSlideY),
                child: RepaintBoundary(
                  child: IntroDetailsContent(
                    nameFontSize: 38.0,
                    roleFontSize: 18.0,
                    bodyFontSize: 13.5,
                    alignment: CrossAxisAlignment.center,
                    textAlign: TextAlign.center,
                    isActive: introReveal > 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Hand-drawn bouncing "SCROLL DOWN" prompt indicator.
class _ScrollDownIndicator extends StatefulWidget {
  final VoidCallback onTap;
  final double opacity;
  final bool isMobile;

  const _ScrollDownIndicator({
    required this.onTap,
    required this.opacity,
    this.isMobile = false,
  });

  @override
  State<_ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<_ScrollDownIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.opacity <= 0.01) {
      return const SizedBox.shrink();
    }

    return Opacity(
      opacity: widget.opacity,
      child: AnimatedBuilder(
        animation: _bounceController,
        builder: (context, _) {
          final double bounceY = _bounceController.value * 7.0;

          return Transform.translate(
            offset: Offset(0, bounceY),
            child: GestureDetector(
              onTap: widget.onTap,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomPaint(
                  size: Size(28, 18),
                  painter: _SketchScrollArrowPainter(seed: 19),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Custom painter for a hand-sketched downward chevron arrow.
class _SketchScrollArrowPainter extends CustomPainter {
  final int seed;

  const _SketchScrollArrowPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint arrowPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path path1 = Path()
      ..moveTo(2, h * 0.25)
      ..lineTo(w * 0.5, h * 0.85)
      ..lineTo(w - 2, h * 0.25);
    canvas.drawPath(path1, arrowPaint);

    final Paint shadowPaint = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.35)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path2 = Path()
      ..moveTo(3, h * 0.20)
      ..lineTo(w * 0.5, h * 0.80)
      ..lineTo(w - 1, h * 0.20);
    canvas.drawPath(path2, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchScrollArrowPainter oldDelegate) => false;
}

/// Draws a delicate, organic hand-drawn sketchbook orbital ring behind the portrait
/// on initial landing.
class _SketchbookHaloPainter extends CustomPainter {
  final bool isMobile;

  const _SketchbookHaloPainter({required this.isMobile});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = isMobile
        ? (size.width * 0.44).clamp(130.0, 220.0)
        : (size.height * 0.40).clamp(210.0, 360.0);

    // Primary pencil orbital ring (wobbly ellipse with graphite grain)
    final Paint ringPaint = Paint()
      ..color = const Color(0x18000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final Path ringPath = Path();
    const int segments = 36;
    for (int i = 0; i <= segments; i++) {
      final double angle = (i / segments) * 2.0 * 3.141592653589793;
      final double wobbleR =
          radius + (i.isEven ? 2.5 : -2.5) + ((i % 3 == 0) ? 1.5 : -1.0);
      final double x = center.dx + wobbleR * 1.15 * math.cos(angle);
      final double y = center.dy + wobbleR * 0.95 * math.sin(angle);
      if (i == 0) {
        ringPath.moveTo(x, y);
      } else {
        ringPath.lineTo(x, y);
      }
    }
    canvas.drawPath(ringPath, ringPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchbookHaloPainter oldDelegate) =>
      oldDelegate.isMobile != isMobile;
}
