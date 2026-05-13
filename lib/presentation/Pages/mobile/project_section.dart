import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';

class MobileProjectSection extends StatelessWidget {
  const MobileProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ResponsiveText(
                'My Projects',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                minFontSize: 24,
                maxFontSize: 30,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildProjectCard(context, 'Project 1', 'Built with Flutter and Firebase.'),
                    const SizedBox(height: 15),
                    _buildProjectCard(context, 'Project 2', 'UI/UX Design in Figma.'),
                    const SizedBox(height: 15),
                    _buildProjectCard(context, 'Project 3', 'Dart backend integration.'),
                    const SizedBox(height: 15),
                    _buildProjectCard(context, 'Project 4', 'Neumorphic UI Design system.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 15),
          ButtonWidget(
            onPressed: () {},
            child: const Text('View', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
