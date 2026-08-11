import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/projects_details.dart';
import '../../core/themes/theme.dart';
import '../../widgets/responsive_text.dart';
import '../../widgets/animations/fade_in_up_widget.dart';
import '../../widgets/section_background_text.dart';
import 'widgets/project_card_widget.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Projects().projects;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final bool isUltrawide = AppSizes.isUltrawide(constraints);
        final double maxWidth = (isMobile || isTablet)
            ? double.infinity
            : (isUltrawide ? 1800 : 1200);

        return Stack(
          children: [
            // Fixed Background Watermark
            const Positioned.fill(child: SectionBackgroundText(text: 'WORKS')),

            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile
                            ? 16
                            : (isTablet ? 26 : (isUltrawide ? 80 : 48)),
                        vertical: isMobile ? 60 : (isUltrawide ? 160 : 120),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Foreground Title
                          FadeInUpWidget(
                            delay: const Duration(milliseconds: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'WORKS',
                                      speed: const Duration(milliseconds: 150),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            fontSize: isMobile
                                                ? 32
                                                : (isTablet
                                                      ? 40
                                                      : (isUltrawide ? 64 : 48)),
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                ResponsiveText(
                                  'A collection of projects that showcase my skills, creativity, and passion for building quality Flutter applications.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    height: 1.8,
                                    fontSize: isMobile
                                        ? 14
                                        : (isTablet ? 16 : 18),
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 60),

                          // Projects List
                          Column(
                            children: List.generate(projects.length, (index) {
                              return FadeInUpWidget(
                                delay: Duration(
                                  milliseconds: 400 + (index * 200),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: isMobile ? 32 : 64,
                                  ),
                                  child: PlayStoreProjectCard(
                                    project: projects[index],
                                    isMobile: isMobile || isTablet,
                                    index: index,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
