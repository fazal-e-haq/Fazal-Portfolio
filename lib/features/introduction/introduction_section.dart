import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme.dart';
import '../../../widgets/animations/fade_in_up_widget.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/responsive_text.dart';
import '../../../widgets/sketch_card.dart';
import '../../../services/resume_downloader.dart';

/// Introduction section — The Hero Space (Light Mode 3D Spatial)
class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isMobile = width < 800;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
              child: isMobile ? const _MobileIntro() : const _DesktopIntro(),
            ),
          ),
        );
      },
    );
  }
}

class _DesktopIntro extends StatelessWidget {
  const _DesktopIntro();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: The Text Content (Floating freely)
        Expanded(
          flex: 5,
          child: FadeInUpWidget(
            delay: const Duration(milliseconds: 200),
            child: _IntroContent(
              nameFontSize: 64.0,
              roleFontSize: 32.0,
              alignment: CrossAxisAlignment.start,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const SizedBox(width: 80),
        // Right: The Image wrapped in a 3D Glass panel
        Expanded(
          flex: 4,
          child: FadeInUpWidget(
            delay: const Duration(milliseconds: 400),
            child: const _HoverGlassImage(
              width: 400,
              height: 520,
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileIntro extends StatelessWidget {
  const _MobileIntro();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          FadeInUpWidget(
            delay: const Duration(milliseconds: 200),
            child: const _HoverGlassImage(
              width: 280,
              height: 380,
            ),
          ),
          const SizedBox(height: 48),
          FadeInUpWidget(
            delay: const Duration(milliseconds: 400),
            child: _IntroContent(
              nameFontSize: 36.0,
              roleFontSize: 20.0,
              alignment: CrossAxisAlignment.center,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

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
        // Greeting
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Hello, I am',
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 4.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Name
        RepaintBoundary(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'FAZAL-E-HAQ',
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: nameFontSize,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
                height: 1.1,
                letterSpacing: -1.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Role (Animated Gradient)
        RepaintBoundary(
          child: _AnimatedGradientText(
            child: Text(
              'Product Designer &\nFlutter Developer',
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: roleFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.textMain, // Masked by gradient
                height: 1.3,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Bio
        ResponsiveText(
          'I believe great software is built with intention, not haste. Every interface, interaction, and line of code is carefully crafted to create products that are fast, intuitive, and built to last.',
          textAlign: textAlign,
          style: const TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.7,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 48),

        // Action Buttons
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 24,
          runSpacing: 24,
          children: [
            _MagneticButton(
              child: ElevatedButton.icon(
                onPressed: downloadResume,
                icon: const Icon(CupertinoIcons.arrow_down, size: 20, color: AppColors.textMain),
                label: const Text(
                  'My Resume',
                  style: TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  elevation: 8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HoverGlassImage extends StatefulWidget {
  final double width;
  final double height;
  const _HoverGlassImage({required this.width, required this.height});

  @override
  State<_HoverGlassImage> createState() => _HoverGlassImageState();
}

class _HoverGlassImageState extends State<_HoverGlassImage> {
  final ValueNotifier<Offset> _localMousePos = ValueNotifier<Offset>(Offset.zero);
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
          _localMousePos.value = event.localPosition - center;
        }
      },
      child: ValueListenableBuilder<Offset>(
        valueListenable: _localMousePos,
        builder: (context, delta, child) {
          double dx = _isHovered ? (delta.dx / (widget.width / 2)) : 0;
          double dy = _isHovered ? (delta.dy / (widget.height / 2)) : 0;

          double maxTilt = 0.08;
          double rotateX = dy * maxTilt * -1;
          double rotateY = dx * maxTilt;

          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _isHovered ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, double hoverProgress, _) {
              final Matrix4 transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(rotateX * hoverProgress)
                ..rotateY(rotateY * hoverProgress);

              return Transform(
                transform: transform,
                alignment: FractionalOffset.center,
                child: SketchCard(
                  width: widget.width,
                  height: widget.height,
                  padding: EdgeInsets.zero,
                  isHovered: _isHovered,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // The actual image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AnimatedScale(
                          duration: const Duration(seconds: 4),
                          scale: _isHovered ? 1.05 : 1.0,
                          curve: Curves.easeOutCubic,
                          child: Image.asset(
                            'assets/Images/my-filter-pic/full-preview.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AnimatedGradientText extends StatefulWidget {
  final Widget child;
  const _AnimatedGradientText({required this.child});

  @override
  State<_AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<_AnimatedGradientText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
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
                AppColors.primary,
              ],
              stops: const [0.0, 1.0],
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

class _MagneticButton extends StatefulWidget {
  final Widget child;
  const _MagneticButton({required this.child});

  @override
  State<_MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<_MagneticButton> {
  final ValueNotifier<Offset> _localMousePos = ValueNotifier<Offset>(Offset.zero);
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
          _localMousePos.value = (event.localPosition - center) * 0.2;
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
