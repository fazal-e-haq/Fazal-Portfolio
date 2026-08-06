import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
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
                    ResponsiveText(
                      'What I Do',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 32 : (isUltrawide ? 64 : 48),
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ResponsiveText(
                      "I'd love to help bring your ideas to life with a smooth, modern, and thoughtfully crafted Flutter application.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        height: 1.8,
                        fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Services Grid
                    Column(
                      children: [
                        ServiceCard(
                          index: 0,
                          title: 'Flutter Development',
                          subtitle: 'Building fast, responsive, and scalable Flutter applications tailored to your needs.',
                          icon: CupertinoIcons.device_phone_portrait,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 16),
                        ServiceCard(
                          index: 1,
                          title: 'Product Designing',
                          subtitle: 'Building fast, responsive, and scalable Flutter applications tailored to your needs.',
                          icon: CupertinoIcons.paintbrush,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 16),
                        ServiceCard(
                          index: 2,
                          title: 'State Management',
                          subtitle: 'Keeping your application fast, organized, and responsive with efficient state management.',
                          icon: CupertinoIcons.layers,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 16),
                        ServiceCard(
                          index: 3,
                          title: 'Backend',
                          subtitle: 'Building secure and reliable backend systems that keep your application running smoothly.',
                          icon: CupertinoIcons.cloud_upload,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 16),
                        ServiceCard(
                          index: 4,
                          title: 'Animation',
                          subtitle: 'Adding smooth and meaningful animations that make every interaction feel natural.',
                          icon: CupertinoIcons.sparkles,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 16),
                        ServiceCard(
                          index: 5,
                          title: 'Responsive Design',
                          subtitle: 'Creating layouts that look and feel great across mobile, tablet, and desktop devices.',
                          icon: CupertinoIcons.resize,
                          isMobile: isMobile,
                        ),
                      ],
                    ),

                    SizedBox(height: isUltrawide ? 120 : 80),

                    // Section 2: Tech Stack
                    ResponsiveText(
                      'Tech Stack',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 32 : (isUltrawide ? 64 : 48),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TechStackSection(isMobile: isMobile),
                    
                    SizedBox(height: isUltrawide ? 120 : 80),

                    // Section 3: Journey Timeline
                    JourneyTimeline(isMobile: isMobile),
                    SizedBox(height: isUltrawide ? 160 : 120),

                    // Section 4: Contact CTA
                    ContactCtaCard(isMobile: isMobile),
                    const SizedBox(height: 80), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        );

        return Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'ABOUT',
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: isUltrawide ? 600 : 400,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          letterSpacing: 20,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = isMobile
                                ? 1.5
                                : (isUltrawide ? 4.0 : 3.0)
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
