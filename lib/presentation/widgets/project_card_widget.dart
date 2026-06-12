import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fazal_portfolio/core/constants/projects_details.dart';
import 'package:fazal_portfolio/models/project_detail_model.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';

class ProjectCardWidget extends StatelessWidget {
  ProjectCardWidget({super.key});

  final List<ProjectDetail> allProjects = Projects().projects;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return ListView.builder(
      itemCount: allProjects.length,
      scrollDirection: isMobile ? Axis.vertical : Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final project = allProjects[index];

        return _ProjectCardItem(project: project, isMobile: isMobile);
      },
    );
  }
}

class _ProjectCardItem extends StatelessWidget {
  final ProjectDetail project;
  final bool isMobile;

  const _ProjectCardItem({required this.project, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProjectProvider>();

    return MouseRegion(
      onEnter: (_) => provider.setHovered(project.projectId, true),
      onExit: (_) => provider.setHovered(project.projectId, false),

      child: Selector<ProjectProvider, bool>(
        selector: (_, p) => p.isHovered(project.projectId),

        builder: (context, isHovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,

            // ✅ RESPONSIVE HEIGHT FIX
            width: isMobile ? double.infinity : 400,

            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: isMobile ? 0 : 16,
            ),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: isHovered
                  ? const Color(0xFF1E1E1E)
                  : const Color(0xFF151515),

              border: Border.all(
                width: 1.5,
                color: isHovered
                    ? Colors.blueAccent.withValues(alpha: 0.4)
                    : const Color(0xFF2A2A2A),
              ),

              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isHovered ? 0.6 : 0.35),
                  blurRadius: isHovered ? 25 : 15,
                  offset: isHovered ? const Offset(10, 10) : const Offset(6, 6),
                ),
              ],
            ),

            child: _ProjectContent(project: project),
          );
        },
      ),
    );
  }
}

class _ProjectContent extends StatelessWidget {
  final ProjectDetail project;

  const _ProjectContent({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            project.pics,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 10),

        // TECHNOLOGIES
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tech,
                style: const TextStyle(fontSize: 11, color: Colors.blue),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        Text(
          project.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.deepOrange),
        ),

        const SizedBox(height: 4),

        Text(project.subTitle, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: 10),

        Text(project.explanation, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 10),

        ButtonWidget(text: const Text("Explore case study"), url: project.url),
      ],
    );
  }
}
