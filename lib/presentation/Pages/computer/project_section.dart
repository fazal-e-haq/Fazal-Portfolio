import 'package:fazal_portfolio/core/models/project_model.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
import 'package:fazal_portfolio/providers/hover_provider.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:provider/provider.dart';

// This section showcases your work/projects with smooth animations and dynamic data
class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Access project data from the provider
    final projectProvider = context.watch<ProjectProvider>();
    final projects = projectProvider.projects;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.85,
          height: size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 30),
                child: Text(
                  'Featured Work',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
              // Horizontal list of projects with staggered animations
              SizedBox(
                height: 480,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: projects.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    
                    // Staggered entry animation: each card starts slightly later than the previous one
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 600 + (index * 200)),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(50 * (1 - value), 0),
                            child: child,
                          ),
                        );
                      },
                      child: _ProjectCard(project: project),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Internal widget for the Project Card to handle its own hover state and aesthetics
class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final hoverProvider = context.watch<HoverProvider>();
    final bool isHovered = hoverProvider.isHovered(project.id);

    return MouseRegion(
      onEnter: (_) => hoverProvider.setHovered(project.id, true),
      onExit: (_) => hoverProvider.setHovered(project.id, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 380,
        margin: const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF1E1E1E) : const Color(0xFF151515),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isHovered ? Colors.blueAccent.withValues(alpha: 0.3) : const Color(0xFF2A2A2A),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isHovered ? 0.6 : 0.4),
              blurRadius: isHovered ? 25 : 15,
              offset: isHovered ? const Offset(12, 12) : const Offset(8, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image Preview with subtle scale effect on hover
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AnimatedScale(
                scale: isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    image: DecorationImage(
                      image: AssetImage(project.imagePath),
                      fit: BoxFit.cover,
                      opacity: isHovered ? 0.5 : 0.3,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.code_rounded,
                      size: 60,
                      color: isHovered ? Colors.blueAccent : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tags/Technologies
            Wrap(
              spacing: 8,
              children: project.technologies.map((tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )).toList(),
            ),
            const SizedBox(height: 15),
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.description,
              style: TextStyle(
                color: Colors.grey.shade400, 
                fontSize: 14, 
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            ButtonWidget(
              url: project.projectUrl,
              onPressed: project.projectUrl == null ? () {} : null,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: const Text('Explore Case Study'),
            ),
          ],
        ),
      ),
    );
  }
}
