import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_shell/scroll_coordinator_controller.dart';

import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../../../services/resume_downloader.dart';
import '../../../widgets/button/button_widget.dart';

class Introduction extends StatelessWidget {
  final ScrollController scrollController;
  
  const Introduction({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 800;

        return SizedBox(
          height: screenHeight * 2.0,
          child: Obx(() {
              double offset = 0.0;
              if (Get.isRegistered<ScrollCoordinatorController>()) {
                offset = Get.find<ScrollCoordinatorController>().scrollOffset.value;
              }

              final progress = (offset / screenHeight).clamp(0.0, 1.0);
              final smoothProgress = Curves.easeInOutCubic.transform(progress);
              final stickOffset = offset < screenHeight ? offset : screenHeight;

              return Transform.translate(
                offset: Offset(0, stickOffset),
                child: SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // 1. Yellow Drops (Background Glow)
                      Positioned(
                        top: screenHeight * 0.1,
                        right: screenWidth * 0.1,
                        child: Opacity(
                          opacity: 1.0 - smoothProgress,
                          child: Container(
                            width: screenWidth * 0.5,
                            height: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.amberAccent.withValues(alpha: 0.15),
                                  Colors.amberAccent.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 2. Huge FAZAL Background Text
                      Positioned.fill(
                        child: Opacity(
                          opacity: 1.0 - smoothProgress,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              'FAZAL',
                              style: TextStyle(
                                fontFamily: 'Patrick Hand',
                                fontSize: screenWidth * 1.5,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 20.0,
                                height: 1.0,
                                color: AppColors.textMain.withValues(alpha: 0.15),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      // 3. Left Content
                      Positioned(
                        left: isMobile ? 24 : screenWidth * 0.1,
                        right: isMobile ? 24 : null,
                        top: isMobile ? screenHeight * 0.55 : null,
                        child: Opacity(
                          opacity: smoothProgress,
                          child: Transform.translate(
                            offset: Offset(0, 50 * (1.0 - smoothProgress)),
                            child: _IntroContent(
                              nameFontSize: isMobile ? 36.0 : 64.0,
                              roleFontSize: isMobile ? 20.0 : 32.0,
                              alignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                              textAlign: isMobile ? TextAlign.center : TextAlign.left,
                            ),
                          ),
                        ),
                      ),

                      // 4. Center Image -> Moves to Right (FULL PREVIEW)
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: isMobile ? Offset(0, smoothProgress * (screenHeight * -0.25)) : Offset(smoothProgress * (screenWidth * 0.25), 0),
                          child: Transform.scale(
                            scale: lerpDouble(1.0, 0.7, smoothProgress), // Removed 1.1 scale which was cropping it
                            child: Image.asset(
                              'assets/Images/my-image/my-pic.png',
                              // Max height ensures full body is always completely visible
                              height: screenHeight * 0.85, 
                              fit: BoxFit.contain, // Guarantee full uncropped preview
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
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
            color: AppColors.textMain,
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
            letterSpacing: -1.0,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 16),
        ResponsiveText(
          'Senior Flutter App Developer',
          style: TextStyle(
            fontSize: roleFontSize,
            color: AppColors.textMain.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 24),
        ResponsiveText(
          'I craft hyper-realistic, highly performant,\nand beautiful cross-platform applications\nwith Flutter & Dart.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textMain.withValues(alpha: 0.7),
            height: 1.6,
            fontFamily: 'Patrick Hand',
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ButtonWidget(
              text: const Text('Download Resume'),
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

