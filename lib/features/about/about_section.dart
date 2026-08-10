import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../../../widgets/animations/fade_in_up_widget.dart';
import '../../../widgets/section_background_text.dart';
import 'widgets/service_card.dart';
import 'widgets/tech_stack_section.dart';
import 'widgets/journey_timeline.dart';
import 'widgets/contact_cta_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final bool isUltrawide = constraints.maxWidth > 1400;

        final Widget content = SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : (isTablet ? 40.0 : 80.0),
              vertical: isMobile ? 60.0 : 100.0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Section 1: What I Do
                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 200),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'What I Do',
                            speed: const Duration(milliseconds: 150),
                            textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : (isUltrawide ? 64 : 48),
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 400),
                      child: ResponsiveText(
                        "I'd love to help bring your ideas to life with a smooth, modern, and thoughtfully crafted Flutter application.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          height: 1.8,
                          fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Services Grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double spacing = 24.0;
                        final double availableWidth = constraints.maxWidth;
                        
                        // Calculate item width based on screen size
                        double itemWidth;
                        if (isMobile) {
                          itemWidth = availableWidth; // 1 column
                        } else if (isTablet) {
                          itemWidth = (availableWidth - spacing) / 2; // 2 columns
                        } else {
                          itemWidth = (availableWidth - (spacing * 2)) / 3; // 3 columns
                        }

                        final services = [
                          {
                            'title': 'Flutter Development',
                            'subtitle': 'Building fast, responsive, and scalable Flutter applications tailored to your needs.',
                            'icon': CupertinoIcons.device_phone_portrait,
                          },
                          {
                            'title': 'Product Designing',
                            'subtitle': 'Crafting intuitive and visually stunning user interfaces with a focus on user experience.',
                            'icon': CupertinoIcons.paintbrush,
                          },
                          {
                            'title': 'State Management',
                            'subtitle': 'Keeping your application fast, organized, and responsive with efficient state management.',
                            'icon': CupertinoIcons.layers,
                          },
                          {
                            'title': 'Backend Integration',
                            'subtitle': 'Building secure and reliable backend connections that keep your application running smoothly.',
                            'icon': CupertinoIcons.cloud_upload,
                          },
                          {
                            'title': 'Smooth Animations',
                            'subtitle': 'Adding smooth and meaningful animations that make every interaction feel natural.',
                            'icon': CupertinoIcons.sparkles,
                          },
                          {
                            'title': 'Responsive Design',
                            'subtitle': 'Creating layouts that look and feel great across mobile, tablet, and desktop devices.',
                            'icon': CupertinoIcons.resize,
                          },
                        ];

                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: List.generate(services.length, (index) {
                            return FadeInUpWidget(
                              delay: Duration(milliseconds: 600 + (index * 200)),
                              child: SizedBox(
                                width: itemWidth,
                                child: ServiceCard(
                                  index: index,
                                  title: services[index]['title'] as String,
                                  subtitle: services[index]['subtitle'] as String,
                                  icon: services[index]['icon'] as IconData,
                                  isMobile: isMobile,
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    ),

                    SizedBox(height: isUltrawide ? 120 : 80),

                    // Section 2: Tech Stack
                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 800),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Tech Stack',
                            speed: const Duration(milliseconds: 150),
                            textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : (isUltrawide ? 64 : 48),
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 1000),
                      child: TechStackSection(isMobile: isMobile),
                    ),
                    
                    SizedBox(height: isUltrawide ? 120 : 80),

                    // Section 3: Journey Timeline
                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 1200),
                      child: JourneyTimeline(isMobile: isMobile),
                    ),
                    SizedBox(height: isUltrawide ? 160 : 120),

                    // Section 4: Contact CTA
                    FadeInUpWidget(
                      delay: const Duration(milliseconds: 1400),
                      child: ContactCtaCard(isMobile: isMobile),
                    ),
                    
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );

        return Stack(
          children: [
            const Positioned.fill(
              child: SectionBackgroundText(text: 'ABOUT'),
            ),
            Positioned.fill(child: content),
          ],
        );
      },
    );
  }
}
