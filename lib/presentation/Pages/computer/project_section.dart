import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';

// This section showcases your work/projects in a horizontal scrolling list
class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.85,
          height: size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'My Projects',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // This horizontal list holds the project cards
              SizedBox(
                height: 420, // Fixed height for horizontal list
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildProjectCard(context, 'Project Title 1', 'Short description of the project goes here. Built with Flutter and Provider.'),
                    const SizedBox(width: 30),
                    _buildProjectCard(context, 'Project Title 2', 'Short description of the project goes here. Built with Firebase and Cloud Firestore.'),
                    const SizedBox(width: 30),
                    _buildProjectCard(context, 'Project Title 3', 'Short description of the project goes here. Built with Dart and custom UI components.'),
                    const SizedBox(width: 30),
                    _buildProjectCard(context, 'Project Title 4', 'Another awesome project showcasing Neumorphic design principles.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This helper function creates an individual project card
  Widget _buildProjectCard(BuildContext context, String title, String desc) {
    return Container(
      width: 350, // Fixed width for horizontal scrolling items
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A placeholder box for the project image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/Images/my_portfolio_pic.png'), // Using profile pic as placeholder
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: const Center(
              child: Icon(Icons.code, size: 50, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.4),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          ButtonWidget(
            onPressed: () {},
            child: const Text('View Project'),
          ),
        ],
      ),
    );
  }
}
