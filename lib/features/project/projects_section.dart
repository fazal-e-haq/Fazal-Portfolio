import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/projects_details.dart';
import '../../core/themes/theme.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/responsive_text.dart';
import 'project_controller.dart';
import 'project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Projects().projects;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        int crossAxisCount = 1;
        if (isTablet) crossAxisCount = 2;
        if (constraints.maxWidth >= 1100) crossAxisCount = 2;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 48,
                  vertical: isMobile ? 40 : 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      'Showcase',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        fontFamily: 'Unbounded',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ResponsiveText(
                      'P r o j e c t s',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: isMobile ? 32 : 48,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 48),
                    isMobile
                        ? Column(
                            children: projects.map((p) => Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: _ProjectCardWidget(project: p),
                                )).toList(),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 32,
                              mainAxisSpacing: 32,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              return _ProjectCardWidget(project: projects[index]);
                            },
                          ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectCardWidget extends StatelessWidget {
  const _ProjectCardWidget({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();

    return MouseRegion(
      onEnter: (_) => controller.setHovered(project.id, true),
      onExit: (_) => controller.setHovered(project.id, false),
      child: Obx(() {
        final isHovered = controller.isHovered(project.id);
        final theme = Theme.of(context);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: AppColors.neumorphicShadows(
              isPressed: isHovered,
              distance: isHovered ? 2 : 10,
              blur: isHovered ? 4 : 20,
              glowColor: isHovered ? AppColors.primary : null,
            ),
            border: Border.all(
              color: isHovered
                  ? theme.primaryColor.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Header
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        duration: const Duration(seconds: 4),
                        scale: isHovered ? 1.05 : 1.0,
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          project.imagePath,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.surface.withValues(alpha: 0.8),
                              AppColors.surface,
                            ],
                            stops: const [0.4, 0.9, 1.0],
                          ),
                        ),
                      ),
                      // Type Badge
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.primaryColor.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            project.type,
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontFamily: 'Unbounded',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Footer
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Unbounded',
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            project.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.6,
                              fontFamily: 'Poppins',
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (project.liveUrl != null) ...[
                              Expanded(
                                child: ButtonWidget(
                                  onPressed: () => _launchUrl(project.liveUrl!),
                                  icon: const Icon(CupertinoIcons.eye, size: 18),
                                  text: const Text('Live Demo'),
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                            if (project.codeUrl != null)
                              Expanded(
                                child: ButtonWidget(
                                  onPressed: () => _launchUrl(project.codeUrl!),
                                  icon: const Icon(CupertinoIcons.chevron_left_slash_chevron_right, size: 18),
                                  text: const Text('Source Code'),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
