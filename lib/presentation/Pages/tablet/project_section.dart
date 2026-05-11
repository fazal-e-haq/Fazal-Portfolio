import 'package:fazal_portfolio/core/models/project_model.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
import 'package:fazal_portfolio/providers/hover_provider.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:provider/provider.dart';

// This is the project section tailored for tablet devices
class TabletProjectSection extends StatelessWidget {
  const TabletProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final projectProvider = context.watch<ProjectProvider>();
    final projects = projectProvider.projects;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          height: size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                child: Text(
                  'Selected Projects',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SizedBox(
                height: 440,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: projects.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 600 + (index * 200)),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(40 * (1 - value), 0),
                            child: child,
                          ),
                        );
                      },
                      child: _TabletProjectCard(project: project),
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

class _TabletProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _TabletProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final hoverProvider = context.watch<HoverProvider>();
    final bool isHovered = hoverProvider.isHovered(project.id);

    return MouseRegion(
      onEnter: (_) => hoverProvider.setHovered(project.id, true),
      onExit: (_) => hoverProvider.setHovered(project.id, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 340,
        margin: const EdgeInsets.only(right: 25),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF1E1E1E) : const Color(0xFF151515),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isHovered ? Colors.blueAccent.withValues(alpha: 0.3) : const Color(0xFF2A2A2A),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isHovered ? 0.5 : 0.3),
              blurRadius: isHovered ? 20 : 12,
              offset: isHovered ? const Offset(10, 10) : const Offset(6, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  image: DecorationImage(
                    image: AssetImage(project.imagePath),
                    fit: BoxFit.cover,
                    opacity: isHovered ? 0.4 : 0.2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.code_rounded,
                    size: 50,
                    color: isHovered ? Colors.blueAccent : Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 6,
              children: project.technologies.take(2).map((tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(color: Colors.blueAccent, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              )).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: TextStyle(
                color: Colors.grey.shade400, 
                fontSize: 13, 
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            ButtonWidget(
              url: project.projectUrl,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: const Text('View Details', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
