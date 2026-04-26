import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.76,
          height: size.height * 0.62,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Projects',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              const Text('Project details coming soon...'),
            ],
          ),
        ),
      ),
    );
  }
}
