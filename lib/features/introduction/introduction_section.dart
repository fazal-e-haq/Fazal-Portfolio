import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/responsive_text.dart';
import '../project/project_controller.dart';
import '../../../services/resume_downloader.dart';

/// Introduction section — The Hero Page
/// Features a stunning 10/10 Neomorphic layout, responsive across all screens.
class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 1100;

        final Widget content = isMobile
            ? const _MobileIntro()
            : _DesktopTabletIntro(isTablet: isTablet);

        return Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    // Prevent static text from repainting when animations run above it
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'INTRO',
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 400,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          letterSpacing: 20,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = isMobile ? 1.5 : 3.0
                            ..color = Colors.white.withValues(alpha: 0.03),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(child: content),
          ],
        );
      },
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Desktop / Tablet Layout
// ────────────────────────────────────────────────────────────────────────────
class _DesktopTabletIntro extends StatelessWidget {
  const _DesktopTabletIntro({required this.isTablet});

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final double nameFontSize = isTablet ? 36.0 : 56.0;
    final double roleFontSize = isTablet ? 22.0 : 35.0;
    final double imageWidth = isTablet ? 280.0 : 380.0;
    final double imageHeight = isTablet ? 380.0 : 500.0; // Rectangular portrait

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT: Profile Image
              Expanded(
                flex: 4,
                child: Center(
                  child: _FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _DesktopImagePreview(
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(width: isTablet ? 40 : 80),
              // RIGHT: Text Content
              Expanded(
                flex: 5,
                child: _IntroContent(
                  nameFontSize: nameFontSize,
                  roleFontSize: roleFontSize,
                  alignment: CrossAxisAlignment.start,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Mobile Layout
// ────────────────────────────────────────────────────────────────────────────
class _MobileIntro extends StatelessWidget {
  const _MobileIntro();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _FadeInUp(
                delay: Duration(milliseconds: 200),
                child: _MobileImagePreview(size: 260),
              ),
            ),
            SizedBox(height: 40),
            _IntroContent(
              nameFontSize: 28.0,
              roleFontSize: 18.0,
              alignment: CrossAxisAlignment.start,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 80), // extra padding at bottom
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Shared Content Widget (Text & Button)
// ────────────────────────────────────────────────────────────────────────────
class _IntroContent extends StatelessWidget {
  const _IntroContent({
    required this.nameFontSize,
    required this.roleFontSize,
    required this.alignment,
    required this.textAlign,
  });

  final double nameFontSize;
  final double roleFontSize;
  final CrossAxisAlignment alignment;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: alignment,
      children: [
        // Rotated Greeting
        _FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Transform.rotate(
              angle: -0.15, // Playful slight rotation
              alignment: Alignment.centerLeft,
              child: const Text(
                'Hello, I am',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),

        // Name
        _FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: RepaintBoundary(
            // Isolate rapid text scrambling repaints
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: _AnimatedGradientText(
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    ScrambleAnimatedText(
                      'FAZAL-E-HAQ',
                      speed: const Duration(milliseconds: 200),
                      textAlign: textAlign,
                      textStyle: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.w900,
                        color: Colors
                            .white, // The gradient colors will show through this
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Role
        _FadeInUp(
          delay: const Duration(milliseconds: 800),
          child: RepaintBoundary(
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(seconds: 3),
              animatedTexts: [
                TyperAnimatedText(
                  'UI/UX Designer',
                  textAlign: textAlign,
                  speed: const Duration(milliseconds: 80),
                  textStyle: TextStyle(
                    fontFamily: 'Unbounded',
                    fontSize: roleFontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                    letterSpacing: 3.0,
                  ),
                ),
                TyperAnimatedText(
                  'Flutter Developer',
                  textAlign: textAlign,
                  speed: const Duration(milliseconds: 80),
                  textStyle: TextStyle(
                    fontFamily: 'Unbounded',
                    fontSize: roleFontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Bio tagline
        _FadeInUp(
          delay: const Duration(milliseconds: 1000),
          child: ResponsiveText(
            'I believe great software is built with intention, not haste. Every interface, interaction, and line of code is carefully crafted to create products that are fast, intuitive, and built to last.',
            textAlign: textAlign,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Action Row: Resume Button + Active Signal
        _FadeInUp(
          delay: const Duration(milliseconds: 1200),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: textAlign == TextAlign.center
                ? WrapAlignment.center
                : WrapAlignment.start,
            spacing: 24,
            runSpacing: 24,
            children: [
              _MagneticButton(
                child: ButtonWidget(
                  onPressed: downloadResume,
                  icon: const Icon(CupertinoIcons.arrow_down, size: 20),
                  text: const Text(
                    'My Resume',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        
        // Stats Row (Experience, Projects, Followers)
        _FadeInUp(
          delay: const Duration(milliseconds: 1400),
          child: SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _StatItem(value: '0.4', label: 'Years\nExperience'),
                  const SizedBox(width: 32),
                  Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.1)),
                  const SizedBox(width: 32),
                  _StatItem(value: '1+', label: 'Projects\nCompleted'),
                  const SizedBox(width: 32),
                  Container(height: 40, width: 1, color: Colors.white.withValues(alpha: 0.1)),
                  const SizedBox(width: 32),
                  _StatItem(value: '1k', label: 'Followers'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            height: 1.3,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Desktop Stacked Rectangular Image Preview
// ────────────────────────────────────────────────────────────────────────────
class _DesktopImagePreview extends StatefulWidget {
  const _DesktopImagePreview({required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<_DesktopImagePreview> createState() => _DesktopImagePreviewState();
}

class _DesktopImagePreviewState extends State<_DesktopImagePreview> {
  final ValueNotifier<Offset> _localMousePos = ValueNotifier<Offset>(
    Offset.zero,
  );
  bool _isHovered = false;

  @override
  void dispose() {
    _localMousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        controller.setHovered('intro_image', true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _localMousePos.value = Offset.zero; // reset
        controller.setHovered('intro_image', false);
      },
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset center = Offset(box.size.width / 2, box.size.height / 2);
          _localMousePos.value =
              event.localPosition - center; // delta from center
        }
      },
      cursor: SystemMouseCursors.click,
      child: ValueListenableBuilder<Offset>(
        valueListenable: _localMousePos,
        builder: (context, delta, child) {
          // Normalize the delta (-1 to 1) based on center
          double dx = _isHovered ? (delta.dx / (widget.width / 2)) : 0;
          double dy = _isHovered ? (delta.dy / (widget.height / 2)) : 0;

          // Max rotation is approx 0.1 radians
          double maxTilt = 0.1;
          double rotateX = dy * maxTilt * -1; // tilt towards mouse
          double rotateY = dx * maxTilt;

          final Matrix4 transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // subtle perspective
            ..rotateX(rotateX)
            ..rotateY(rotateY);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            transform: transform,
            transformAlignment: FractionalOffset.center,
            width: widget.width,
            height: widget.height,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // 1. Backing Neomorphic Offset Frame (Parallax moving opposite)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  top: 24 - (dy * 15),
                  left: -24 - (dx * 15),
                  right: 24 + (dx * 15),
                  bottom: -24 + (dy * 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: _isHovered
                            ? AppColors.primary.withValues(alpha: 0.6)
                            : AppColors.textMuted.withValues(alpha: 0.1),
                        width: 2,
                      ),
                      boxShadow: AppColors.neumorphicShadows(
                        distance: _isHovered ? 16 : 8,
                        blur: _isHovered ? 24 : 16,
                        glowColor: _isHovered ? AppColors.primary : null,
                      ),
                    ),
                  ),
                ),

                // 2. Front Image Card
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  top: -12 + (dy * 8),
                  left: 12 + (dx * 8),
                  right: -12 - (dx * 8),
                  bottom: 12 - (dy * 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 30,
                          offset: Offset(dx * -15, 15 + dy * -15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedScale(
                        duration: const Duration(seconds: 15),
                        scale: _isHovered ? 1.08 : 1.0,
                        curve: Curves.easeOutCubic,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/Images/my-filter-pic/black-full.jpeg',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                            AnimatedOpacity(
                              duration: const Duration(
                                milliseconds: 1000,
                              ), // Very smooth & attractive fade
                              curve: Curves.easeInOutCubic,
                              opacity: _isHovered ? 1.0 : 0.0,
                              child: Image.asset(
                                'assets/Images/my-filter-pic/full-preview.jpeg',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Mobile Circular Colored Image Preview
// ────────────────────────────────────────────────────────────────────────────
class _MobileImagePreview extends StatelessWidget {
  const _MobileImagePreview({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        boxShadow: AppColors.neumorphicShadows(distance: 12, blur: 24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0), // Inner ring gap
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.asset(
            'assets/Images/my-filter-pic/full-preview.jpeg', // Pure color for mobile
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Animation Helper: FadeInUp
// ────────────────────────────────────────────────────────────────────────────
class _FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _FadeInUp({required this.child, required this.delay});

  @override
  State<_FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<_FadeInUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _timer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Advanced Micro-Interactions
// ────────────────────────────────────────────────────────────────────────────

/// Applies an animated shifting gradient mask to its child (e.g., text)
class _AnimatedGradientText extends StatefulWidget {
  final Widget child;
  const _AnimatedGradientText({required this.child});

  @override
  State<_AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<_AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                AppColors.primary,
                AppColors.secondary,
                AppColors.primary,
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(
                _controller.value * 2 * 3.14159,
              ), // Rotate the gradient
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

/// Makes a button slightly pull towards the mouse cursor
class _MagneticButton extends StatefulWidget {
  final Widget child;
  const _MagneticButton({required this.child});

  @override
  State<_MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<_MagneticButton> {
  final ValueNotifier<Offset> _localMousePos = ValueNotifier<Offset>(
    Offset.zero,
  );
  bool _isHovered = false;

  @override
  void dispose() {
    _localMousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) {
        setState(() => _isHovered = false);
        _localMousePos.value = Offset.zero;
      },
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset center = Offset(box.size.width / 2, box.size.height / 2);
          final Offset delta = event.localPosition - center;
          _localMousePos.value = delta * 0.25; // Pull strength
        }
      },
      child: ValueListenableBuilder<Offset>(
        valueListenable: _localMousePos,
        builder: (context, offset, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(
              _isHovered ? offset.dx : 0,
              _isHovered ? offset.dy : 0,
              0,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}
