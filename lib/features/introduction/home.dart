import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/themes/theme.dart';
import '../../../services/resume_downloader_stub.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/responsive_text.dart';
import '../project/project_controller.dart';

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

        if (isMobile) {
          return const _MobileIntro();
        } else {
          return _DesktopTabletIntro(isTablet: isTablet);
        }
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
    final double imageSize = isTablet ? 300.0 : 420.0;

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
                child: Center(child: ImagePreview(size: imageSize)),
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ImagePreview(size: 260),
            const SizedBox(height: 40),
            const _IntroContent(
              nameFontSize: 28.0,
              roleFontSize: 18.0,
              alignment: CrossAxisAlignment.center,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80), // extra padding at bottom
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
        // Greeting badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppColors.neumorphicShadows(isPressed: true),
          ),
          child: const Text(
            '👋 Hello, I am',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Name
        FittedBox(
          fit: BoxFit.scaleDown,
          child: RepaintBoundary(
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
                    color: AppColors.primary,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Role
        RepaintBoundary(
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
        const SizedBox(height: 24),
        // Bio tagline
        ResponsiveText(
          'Crafting pixel-perfect, high-performance applications with a focus on exceptional user experiences and clean architecture.',
          textAlign: textAlign,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 40),
        // Resume Button
        ButtonWidget(
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
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
//  Image Preview with Neomorphic Hover Effects
// ────────────────────────────────────────────────────────────────────────────
class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();
    return MouseRegion(
      onEnter: (_) => controller.setHovered('intro_image', true),
      onExit: (_) => controller.setHovered('intro_image', false),
      cursor: SystemMouseCursors.click,
      child: Obx(() {
        final isHovered = controller.isHovered('intro_image');

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            boxShadow: AppColors.neumorphicShadows(
              distance: isHovered ? 20 : 12,
              blur: isHovered ? 30 : 20,
              glowColor: isHovered ? AppColors.primary : null,
            ),
            border: Border.all(
              color: isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.textMuted.withValues(alpha: 0.1),
              width: isHovered ? 3 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Inner ring spacing
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: AnimatedScale(
                duration: const Duration(seconds: 10),
                scale: isHovered ? 1.1 : 1.0,
                curve: Curves.easeOutCubic,
                child: Image.asset(
                  isHovered
                      ? 'assets/Images/my-filter-pic/full-preview.jpeg'
                      : 'assets/Images/my-filter-pic/black-full.jpeg',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
