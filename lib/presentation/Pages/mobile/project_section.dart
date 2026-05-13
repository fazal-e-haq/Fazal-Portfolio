import 'package:fazal_portfolio/core/models/project_model.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:provider/provider.dart';

// This is the project section tailored for mobile devices
class MobileProjectSection extends StatelessWidget {
  const MobileProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final projectProvider = context.watch<ProjectProvider>();
    final projects = projectProvider.projects;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.92,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ResponsiveText(
                'My Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                minFontSize: 24,
                maxFontSize: 30,
              ),
              const SizedBox(height: 30),
              // Changed to horizontal scrolling as requested
            _MobileProjectsCards( ),

            ],
          ),
        ),
      ),
    );
  }
}

class _MobileProjectsCards extends StatefulWidget {
  const _MobileProjectsCards({super.key});

  @override
  State<_MobileProjectsCards> createState() => _MobileProjectsCardsState();
}

class _MobileProjectsCardsState extends State<_MobileProjectsCards> {
  int _currentIndex = 0;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects;
    final size = MediaQuery.of(context).size;

    if (projects.isEmpty) return const SizedBox();

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.7, // Increased height
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(
              (projects.length - _currentIndex).clamp(0, 3),
              (index) {
                int stackIndex = (projects.length - _currentIndex).clamp(0, 3) - 1 - index;
                ProjectModel project = projects[_currentIndex + stackIndex];

                return _buildProjectCard(
                  project: project,
                  index: stackIndex,
                  isTop: stackIndex == 0,
                  size: size,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 25),
        // Premium indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            projects.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == index ? Colors.blueAccent : Colors.white24,
                boxShadow: _currentIndex == index ? [
                  BoxShadow(color: Colors.blueAccent.withValues(alpha: 0.4), blurRadius: 8)
                ] : [],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard({
    required ProjectModel project,
    required int index,
    required bool isTop,
    required Size size,
  }) {
    // Elegant, subtle rotations for a smooth fanning effect
    double baseRotation = (index == 0) ? -0.015 : (index == 1 ? 0.025 : -0.035);
    
    double scale = 1.0 - (index * 0.05);
    double opacity = 1.0 - (index * 0.25);
    double verticalOffset = index * 20.0;

    if (isTop) {
      return GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _dragOffset += details.delta.dx;
            _isDragging = true;
          });
        },
        onHorizontalDragEnd: (details) {
          if (_dragOffset.abs() > 140) {
            setState(() {
              _currentIndex = (_currentIndex + 1) % context.read<ProjectProvider>().projects.length;
              _dragOffset = 0;
            });
          } else {
            setState(() { _dragOffset = 0; });
          }
          _isDragging = false;
        },
        child: TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: _isDragging ? 0 : 500),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0, end: _dragOffset),
          builder: (context, value, child) {
            // PERFORMANCE: Use RepaintBoundary to isolate the expensive 3D transform
            return RepaintBoundary(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0008)
                  ..translate(value, value.abs() * 0.2)
                  ..rotateZ(baseRotation + (value / 500)),
                child: child,
              ),
            );
          },
          child: _ProjectCardContent(project: project, size: size, isTop: true, dragOffset: _dragOffset),
        ),
      );
    }

    return RepaintBoundary(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0008)
          ..translate(0.0, verticalOffset)
          ..scale(scale)
          ..rotateZ(baseRotation),
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: _ProjectCardContent(project: project, size: size, isTop: false),
        ),
      ),
    );
  }
}

class _ProjectCardContent extends StatelessWidget {
  final ProjectModel project;
  final Size size;
  final bool isTop;
  final double dragOffset;

  const _ProjectCardContent({
    required this.project, 
    required this.size, 
    this.isTop = false,
    this.dragOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    // PERFORMANCE: Pre-calculate values to avoid logic in build
    final double dragAbs = dragOffset.abs();
    final double glowAlpha = (dragAbs / 500).clamp(0.0, 0.2); // Reduced max alpha
    
    Color glowColor = Colors.transparent;
    if (isTop && dragOffset != 0) {
      glowColor = dragOffset > 0 ? Colors.greenAccent : Colors.redAccent;
    }

    return Container(
      height: size.height * 0.65,
      width: size.width * 0.82,
      padding: const EdgeInsets.all(1.5), // Thinner border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.15), 
            Colors.white.withValues(alpha: 0.05)
          ],
        ),
        boxShadow: [
          if (isTop && dragOffset != 0)
            BoxShadow(
              color: glowColor.withValues(alpha: glowAlpha),
              blurRadius: 20, // Reduced blur
              spreadRadius: 2,
            ),
          const BoxShadow(
            color: Colors.black54,
            blurRadius: 15, // Reduced blur for performance
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PERFORMANCE: Wrap image in RepaintBoundary
            Expanded(
              flex: 6,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF222222),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                size: 50,
                                color: Colors.white10,
                              ),
                            ),
                            Image.asset(
                              project.imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              opacity: const AlwaysStoppedAnimation(0.4),
                              errorBuilder: (context, error, stackTrace) => const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: const Icon(Icons.arrow_outward_rounded, size: 14, color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              project.title.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.blueAccent,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.5),
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            ButtonWidget(
              url: project.projectUrl,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Center(
                child: Text(
                  'VIEW CASE STUDY',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
