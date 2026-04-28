import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';

class TabletProjectSection extends StatelessWidget {
  const TabletProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          height: size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'My Projects',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // This horizontal list holds the project cards
              SizedBox(
                height: 400, // Fixed height for horizontal list
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildProjectCard(context, 'Project Title 1', 'Short description of the project goes here. Built with Flutter.'),
                    const SizedBox(width: 25),
                    _buildProjectCard(context, 'Project Title 2', 'Short description of the project goes here. Built with Firebase.'),
                    const SizedBox(width: 25),
                    _buildProjectCard(context, 'Project Title 3', 'Short description of the project goes here. Built with Dart.'),
                    const SizedBox(width: 25),
                    _buildProjectCard(context, 'Project Title 4', 'Another awesome project built by Fazal.'),
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
      width: 320, // Fixed width for horizontal scrolling items
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/Images/my_portfolio_pic.png'),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
            child: const Center(
              child: Icon(Icons.code, size: 45, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          ButtonWidget(
            onPressed: () {},
            child: const Text('View Project', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
