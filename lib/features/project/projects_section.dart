import 'package:flutter/cupertino.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/projects_details.dart';
import '../../features/project/project_model.dart';
import '../../core/themes/theme.dart';
import '../../widgets/animations/fade_in_up_widget.dart';
import '../../widgets/sketch_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final projects = Projects().projects;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80),
              child: Column(
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
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'FEATURED WORKS',
                        style: TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                          letterSpacing: 4.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  
                  // Horizontal 3D Carousel of Projects
                  SizedBox(
                    height: isMobile ? 450 : 500,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: FadeInUpWidget(
                            delay: Duration(milliseconds: 200 + (index * 150)),
                            child: _ProjectGlassCard(
                              project: projects[index],
                              isMobile: isMobile,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectGlassCard extends StatefulWidget {
  final ProjectModel project;
  final bool isMobile;

  const _ProjectGlassCard({required this.project, required this.isMobile});

  @override
  State<_ProjectGlassCard> createState() => _ProjectGlassCardState();
}

class _ProjectGlassCardState extends State<_ProjectGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: SketchCard(
          width: widget.isMobile ? 320 : 400,
          padding: EdgeInsets.zero, // We will pad inside
          isHovered: _isHovered,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mock Image area (gradient for now, can be an actual image later)
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      border: Border(
                        bottom: BorderSide(color: AppColors.textMain, width: 2),
                      ),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.device_phone_portrait, size: 64, color: AppColors.textMain),
                    ),
                  ),
                ),
              ),
              
              // Text Content Area
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          widget.project.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Project',
                            style: TextStyle(
                              fontFamily: 'Patrick Hand',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _isHovered ? AppColors.primary : AppColors.secondary,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.arrow_right,
                            size: 16,
                            color: _isHovered ? AppColors.primary : AppColors.secondary,
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
      ),
    );
  }
}
