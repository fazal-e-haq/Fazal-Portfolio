import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../about_controller.dart';

class JourneyTimeline extends StatelessWidget {
  final bool isMobile;

  const JourneyTimeline({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final timelineData = [
      {
        'year': '2025',
        'title': 'The Beginning',
        'description': 'Started learning Flutter and diving deep into cross-platform app development.',
        'isHighlighted': false,
      },
      {
        'year': 'Currently',
        'title': 'Building & Expanding',
        'description': 'Now focusing on freelancing and job opportunities. Currently working on launching the CutCount app with more features, and open to freelancing projects.',
        'isHighlighted': true,
      }
    ];

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        ResponsiveText(
          'My Journey',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 32 : 48,
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 60),
        ...timelineData.asMap().entries.map((entry) {
          return _buildTimelineItem(
            index: entry.key,
            year: entry.value['year'] as String,
            title: entry.value['title'] as String,
            description: entry.value['description'] as String,
            isLast: entry.key == timelineData.length - 1,
            isMobile: isMobile,
            isHighlighted: entry.value['isHighlighted'] as bool,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTimelineItem({
    required int index,
    required String year,
    required String title,
    required String description,
    required bool isLast,
    required bool isMobile,
    bool isHighlighted = false,
  }) {
    final controller = Get.find<AboutController>();
    final String hoverKey = 'journey_$year';
    final bool isLeft = index % 2 == 0;

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: isMobile
          ? _buildMobileLayout(hoverKey, year, title, description, isLast, controller, isHighlighted)
          : _buildDesktopLayout(hoverKey, year, title, description, isLast, isLeft, controller, isHighlighted),
    );
  }

  Widget _buildMobileLayout(String hoverKey, String year, String title, String description, bool isLast, AboutController controller, bool isHighlighted) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 19,
            top: 24,
            bottom: 0,
            child: Container(
              width: 2,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNode(hoverKey, controller, isHighlighted),
            const SizedBox(width: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: _buildCard(hoverKey, year, title, description, controller, isHighlighted),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(String hoverKey, String year, String title, String description, bool isLast, bool isLeft, AboutController controller, bool isHighlighted) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 0,
            right: 0,
            top: 24,
            bottom: 0,
            child: Center(
              child: Container(
                width: 2,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: isLeft
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 60.0, right: 48.0),
                      child: _buildCard(hoverKey, year, title, description, controller, isHighlighted, alignRight: true),
                    )
                  : const SizedBox(),
            ),
            _buildNode(hoverKey, controller, isHighlighted),
            Expanded(
              child: !isLeft
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 60.0, left: 48.0),
                      child: _buildCard(hoverKey, year, title, description, controller, isHighlighted),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNode(String hoverKey, AboutController controller, bool isHighlighted) {
    return SizedBox(
      width: 40,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Obx(() {
            final bool isHovered = controller.isHovered(hoverKey);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: isHovered || isHighlighted ? 24 : 16,
              height: isHovered || isHighlighted ? 24 : 16,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: isHovered || isHighlighted ? 6 : 3,
                ),
                boxShadow: isHovered || isHighlighted
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCard(String hoverKey, String year, String title, String description, AboutController controller, bool isHighlighted, {bool alignRight = false}) {
    return Obx(() {
      final bool isHovered = controller.isHovered(hoverKey);
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered ? AppColors.primary.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: isHovered ? AppColors.neumorphicShadows(distance: 8, blur: 20) : null,
        ),
        child: Column(
          crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              year,
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w900,
                color: isHovered || isHighlighted ? AppColors.primary : Colors.white24,
              ),
            ),
            const SizedBox(height: 8),
            ResponsiveText(
              title,
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            ResponsiveText(
              description,
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    });
  }
}
