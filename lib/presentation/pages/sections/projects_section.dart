import 'package:fazal_portfolio/presentation/widgets/neomorphism_information_card.dart';
import 'package:fazal_portfolio/presentation/widgets/project_card_widget.dart';
import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;
    return NeomorphismInformationCard(
      height: size.height * 0.75,
      width: size.width * 0.8,

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Align(
              alignment: isMobile
                  ? AlignmentGeometry.center
                  : AlignmentGeometry.topLeft,
              child: Text(
                'P r o j e c t s',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: ProjectCardWidget()),
          ],
        ),
      ),
    );
  }
}
