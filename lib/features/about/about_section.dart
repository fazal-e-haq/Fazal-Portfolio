import 'package:flutter/cupertino.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/animations/fade_in_up_widget.dart';
import '../../../widgets/sketch_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : (isTablet ? 40.0 : 80.0),
              ),
              child: isMobile ? const _MobileBentoGrid() : const _DesktopBentoGrid(),
            ),
          ),
        );
      },
    );
  }
}

class _DesktopBentoGrid extends StatelessWidget {
  const _DesktopBentoGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
              'ABOUT ME',
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
        const SizedBox(height: 48),
        SizedBox(
          height: 720,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Column (Big Bio Box)
              Expanded(
                flex: 5,
                child: FadeInUpWidget(
                  delay: const Duration(milliseconds: 200),
                  child: SketchCard(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(CupertinoIcons.person_crop_square, size: 48, color: AppColors.primary),
                        const SizedBox(height: 24),
                        const Text(
                          'The Journey',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'As a Flutter developer, I craft mobile experiences that combine performance with elegant design. I transform concepts into smooth, scalable apps with clean code, responsive layouts, and thoughtful interactions.',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Beyond development, I work as a Product Designer, shaping ideas into meaningful and visually engaging experiences. I focus on intuitive journeys, modern aesthetics, and designs that connect naturally with users.',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const Spacer(),
                        _buildStatusIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              
              // Right Column (Stacked Bento Boxes)
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    // Top Right (Tech Stack)
                    Expanded(
                      flex: 6,
                      child: FadeInUpWidget(
                        delay: const Duration(milliseconds: 350),
                        child: SketchCard(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tech Arsenal',
                                style: TextStyle(
                                  fontFamily: 'Patrick Hand',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textMain,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Expanded(
                                child: Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    _buildTechPill('Flutter'),
                                    _buildTechPill('Dart'),
                                    _buildTechPill('Firebase'),
                                    _buildTechPill('Figma'),
                                    _buildTechPill('UI/UX'),
                                    _buildTechPill('GetX'),
                                    _buildTechPill('REST APIs'),
                                    _buildTechPill('Adobe XD'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Bottom Right (Stats)
                    const Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            child: FadeInUpWidget(
                              delay: Duration(milliseconds: 500),
                              child: SketchCard(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0.4+',
                                      style: TextStyle(
                                        fontFamily: 'Patrick Hand',
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Years\nExperience',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Patrick Hand',
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: FadeInUpWidget(
                              delay: Duration(milliseconds: 650),
                              child: SketchCard(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2+',
                                      style: TextStyle(
                                        fontFamily: 'Patrick Hand',
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Projects\nCompleted',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Patrick Hand',
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.shadowDark.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Patrick Hand',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textMain,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Open for new opportunities',
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textMain,
          ),
        ),
      ],
    );
  }
}

class _MobileBentoGrid extends StatelessWidget {
  const _MobileBentoGrid();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'ABOUT ME',
            style: TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 4.0,
            ),
          ),
          const SizedBox(height: 32),
          
          // Bio Box
          const FadeInUpWidget(
            delay: Duration(milliseconds: 200),
            child: SketchCard(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.person_crop_square, size: 36, color: AppColors.primary),
                  SizedBox(height: 16),
                  Text(
                    'The Journey',
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Crafting mobile experiences that combine performance with elegant design. Transforming concepts into smooth, scalable apps with clean code.',
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Tech Stack Box
          FadeInUpWidget(
            delay: const Duration(milliseconds: 350),
            child: SketchCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tech Arsenal',
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildMobileTechPill('Flutter'),
                      _buildMobileTechPill('Dart'),
                      _buildMobileTechPill('Firebase'),
                      _buildMobileTechPill('UI/UX'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Stats Row
          const Row(
            children: [
              Expanded(
                child: FadeInUpWidget(
                  delay: Duration(milliseconds: 500),
                  child: SketchCard(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          '0.4+',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Years Exp.',
                          style: TextStyle(fontFamily: 'Patrick Hand', fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: FadeInUpWidget(
                  delay: Duration(milliseconds: 650),
                  child: SketchCard(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          '2+',
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: AppColors.secondary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Projects',
                          style: TextStyle(fontFamily: 'Patrick Hand', fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildMobileTechPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.shadowDark.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Patrick Hand',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textMain,
        ),
      ),
    );
  }
}

