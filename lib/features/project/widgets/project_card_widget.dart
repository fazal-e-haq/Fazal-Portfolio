import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/button/button_widget.dart';
import '../../../widgets/responsive_text.dart';
import '../project_model.dart';
import '../project_controller.dart';

class PlayStoreProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isMobile;
  final int index;

  const PlayStoreProjectCard({
    super.key,
    required this.project,
    required this.isMobile,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();
    final String hoverKey = 'project_card_$index';
    
    const double cardRadius = 24.0;
    final double cardPadding = isMobile ? 16 : 40;
    
    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: Obx(() {
        final bool isHovered = controller.isHovered(hoverKey);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutExpo,
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(cardRadius),
            border: Border.all(
              color: isHovered ? AppColors.primary.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.03),
              width: 1,
            ),
            boxShadow: isHovered ? AppColors.neumorphicShadows(distance: 10, blur: 30, glowColor: AppColors.primary.withValues(alpha: 0.05)) : null,
          ),
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(),
              const SizedBox(height: 24),
              _buildActionRow(),
              const SizedBox(height: 32),
              _buildScreenshotGallery(),
              const SizedBox(height: 32),
              _buildTags(),
              const SizedBox(height: 16),
              _buildDescription(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeaderRow() {
    final String projectId = (index + 1).toString().padLeft(2, '0');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo
        Container(
          width: isMobile ? 72 : 96,
          height: isMobile ? 72 : 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppColors.neumorphicShadows(distance: 5, blur: 15),
            image: DecorationImage(
              image: AssetImage(project.logo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // Title and Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                project.title,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: isMobile ? 18 : 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              ResponsiveText(
                project.shortDescription,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: isMobile ? 12 : 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              
              // Ratings and Downloads
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    _buildStatItem(project.rating, RegExp(r'^[0-9.]+$').hasMatch(project.rating) ? '★' : '', 'Rating'),
                    _buildDivider(),
                    _buildStatItem(project.downloads, project.downloads.endsWith('+') || !RegExp(r'^[0-9]+[KMBkmb]?\+?$').hasMatch(project.downloads) ? '' : '+', 'Downloads'),
                    _buildDivider(),
                    _buildStatItem(project.type, '', 'Category'),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Stylish Project ID Watermark
        Text(
          projectId,
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: isMobile ? 40 : 64,
            fontWeight: FontWeight.w900,
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white24,
    );
  }

  Widget _buildStatItem(String value, String suffix, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            ResponsiveText(
              value,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (suffix.isNotEmpty) ...[
              const SizedBox(width: 2),
              ResponsiveText(
                suffix,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: isMobile ? 10 : 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
            ]
          ],
        ),
        const SizedBox(height: 2),
        ResponsiveText(
          label,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isMobile ? 9 : 11,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow() {
    return SizedBox(
      width: double.infinity,
      child: ButtonWidget(
        url: project.liveUrl ?? project.codeUrl,
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        text: const Text(
          'View',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotGallery() {
    return SizedBox(
      height: isMobile ? 250 : 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: project.screenshots.length,
        itemBuilder: (context, idx) {
          return Container(
            width: isMobile ? 140 : 200,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
              image: DecorationImage(
                image: AssetImage(project.screenshots[idx]),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              boxShadow: AppColors.neumorphicShadows(distance: 5, blur: 15),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: project.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceInner,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      project.description,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
