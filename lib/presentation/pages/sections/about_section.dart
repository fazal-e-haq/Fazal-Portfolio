import 'package:fazal_portfolio/core/constants/social_medias_links.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/neomorphism_information_card.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double cardWidth;

    if (size.width < 600) {
      cardWidth = size.width * 0.95;
    } else if (size.width < 900) {
      cardWidth = size.width * 0.90;
    } else {
      cardWidth = size.width * 0.80;
    }

    return AboutSectionForTabletAndDesktop(
      height: size.height.clamp(500.0, 900.0),
      width: cardWidth,
    );
  }
}

// Section for Tablet and Desktop View
class AboutSectionForTabletAndDesktop extends StatelessWidget {
  const AboutSectionForTabletAndDesktop({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isMobile = size.width < 600;
    final bool isTablet = size.width >= 600 && size.width < 900;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: NeomorphismInformationCard(
          height: height,
          width: width,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: 12,
            ),
            children: [
              SizedBox(height: isMobile ? 16 : 24),

              // ABOUT TITLE
              Text(
                'A b o u t   m e',
                style: isMobile
                    ? Theme.of(context).textTheme.titleLarge
                    : isTablet
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: isMobile ? 16 : 24),

              // SUBTITLE
              Text(
                'I am a Flutter Developer & UI/UX Designer',
                style: isMobile
                    ? Theme.of(context).textTheme.bodyMedium
                    : isTablet
                    ? Theme.of(context).textTheme.bodyLarge
                    : Theme.of(context).textTheme.titleMedium,
              ),

              SizedBox(height: isMobile ? 12 : 16),

              // DESCRIPTION
              Text(
                '     ${SocialMediasLinks().aboutMeOfFlutter}\n\n     ${SocialMediasLinks().aboutMeOfDesigner}',
                style: isMobile
                    ? Theme.of(context).textTheme.bodySmall
                    : Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: isMobile ? 24 : 32),

              // SOCIAL BUTTONS
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ButtonWidget(
                    icon: const Icon(Icons.mail),
                    url: SocialMediasLinks().emailAccountLink,
                    text: const Text('Email'),
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    icon: const Icon(Icons.code),
                    url: SocialMediasLinks().githubAccountLink,
                    text: const Text('Github'),
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    url: SocialMediasLinks().instagramAccountLink,
                    icon: const Icon(Icons.camera_alt),
                    text: const Text('Instagram'),
                    onPressed: () {},
                  ),
                  ButtonWidget(
                    url: SocialMediasLinks().linkedinAccountLink,
                    icon: const Icon(Icons.link),
                    text: const Text('LinkedIn'),
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 32 : 55),

              // SKILLS TITLE
              Text(
                'S k i l l s',
                style: isMobile
                    ? Theme.of(context).textTheme.titleLarge
                    : isTablet
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: isMobile ? 16 : 24),

              // SKILLS
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  technicalSkillsButton(
                    context,
                    Colors.blue,
                    'Flutter',
                    Icons.flutter_dash,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.pinkAccent,
                    'Figma',
                    Icons.design_services,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.orange,
                    'Firebase',
                    Icons.local_fire_department,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.deepOrange,
                    'Github',
                    Icons.call_merge,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.green,
                    'Android Studio',
                    Icons.android,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.purple,
                    'RestFul-API',
                    Icons.api,
                  ),
                  technicalSkillsButton(
                    context,
                    Colors.cyan,
                    'Antigravity',
                    Icons.rocket_launch,
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 20 : 30),
            ],
          ),
        ),
      ),
    );
  }

  ButtonWidget technicalSkillsButton(
    BuildContext context,
    Color color,
    String skillName,
    IconData icon,
  ) {
    final size = MediaQuery.of(context).size;

    double iconSize;

    if (size.width < 600) {
      iconSize = 18;
    } else if (size.width < 900) {
      iconSize = 22;
    } else {
      iconSize = 26;
    }

    return ButtonWidget(
      onPressed: () {},
      icon: Icon(icon, color: color, size: iconSize),
      color: color.withValues(alpha: 0.15),
      text: Text(skillName),
    );
  }
}
