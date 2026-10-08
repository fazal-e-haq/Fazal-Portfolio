import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../../../services/resume_downloader.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/responsive_text.dart';
import '../app_shell/scroll_coordinator_controller.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = AppSizes.isMobile(constraints);

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isMobile ? screenHeight * 0.75 : screenHeight * 0.85,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle static watermark background text
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'FAZAL',
                        style: TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: isMobile ? screenWidth * 0.5 : screenWidth * 0.35,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 24.0,
                          height: 1.0,
                          color: AppColors.textMain.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Main Hero Content
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24.0 : 48.0,
                      vertical: isMobile ? 40.0 : 64.0,
                    ),
                    child: isMobile
                        ? _buildMobileLayout(context)
                        : _buildDesktopLayout(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Introduction copy & buttons
        const Expanded(
          flex: 6,
          child: _IntroContent(
            nameFontSize: 60.0,
            roleFontSize: 30.0,
            alignment: CrossAxisAlignment.start,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(width: 48),

        // Right Column: Full preview of the image (uncropped, complete picture)
        Expanded(
          flex: 5,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 520,
                maxWidth: 460,
              ),
              child: Image.asset(
                'assets/Images/my-image/my-pic.png',
                fit: BoxFit.contain, // Guarantee full uncropped preview of whole image
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image on top (Full preview, uncropped)
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 340,
            maxWidth: 320,
          ),
          child: Image.asset(
            'assets/Images/my-image/my-pic.png',
            fit: BoxFit.contain, // Full preview, never cropped
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(height: 32),

        // Intro Text & CTAs
        const _IntroContent(
          nameFontSize: 40.0,
          roleFontSize: 22.0,
          alignment: CrossAxisAlignment.center,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _IntroContent extends StatelessWidget {
  final double nameFontSize;
  final double roleFontSize;
  final CrossAxisAlignment alignment;
  final TextAlign textAlign;

  const _IntroContent({
    required this.nameFontSize,
    required this.roleFontSize,
    required this.alignment,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        ResponsiveText(
          'Hello, I am',
          style: TextStyle(
            fontSize: roleFontSize * 0.75,
            color: AppColors.textMain.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 8),
        ResponsiveText(
          'FAZAL-E-HAQ',
          style: TextStyle(
            fontSize: nameFontSize,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
            height: 1.1,
            letterSpacing: -0.5,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 12),
        ResponsiveText(
          'Senior Flutter App Developer & UI/UX Designer',
          style: TextStyle(
            fontSize: roleFontSize,
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 20),
        ResponsiveText(
          'I craft hyper-realistic, highly performant, and beautiful cross-platform applications with Flutter & Dart.',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textMain.withValues(alpha: 0.75),
            height: 1.6,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ButtonWidget(
              id: 'intro_view_works_btn',
              text: const Text('View My Work'),
              icon: const Icon(CupertinoIcons.sparkles, size: 18, color: AppColors.textMain),
              onPressed: () {
                if (Get.isRegistered<ScrollCoordinatorController>()) {
                  Get.find<ScrollCoordinatorController>().scrollToSection(2);
                }
              },
            ),
            ButtonWidget(
              id: 'intro_resume_btn',
              text: const Text('Download Resume'),
              icon: const Icon(CupertinoIcons.arrow_down_to_line, size: 18, color: AppColors.textMain),
              onPressed: () {
                downloadResume();
              },
            ),
          ],
        ),
      ],
    );
  }
}
