import 'package:fazal_portfolio/core/constants/social_medias_links.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/button_widget.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;
    final bool isTablet = size.width >= 600 && size.width < 900;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 48,
            vertical: isMobile ? 40 : 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ABOUT TITLE
              Text(
                'A b o u t   m e',
                style: (isMobile
                        ? Theme.of(context).textTheme.titleLarge
                        : isTablet
                            ? Theme.of(context).textTheme.headlineSmall
                            : Theme.of(context).textTheme.headlineMedium)
                    ?.copyWith(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              // SUBTITLE
              Text(
                'I am a Flutter Developer & UI/UX Designer',
                style: (isMobile
                        ? Theme.of(context).textTheme.bodyMedium
                        : isTablet
                            ? Theme.of(context).textTheme.bodyLarge
                            : Theme.of(context).textTheme.titleMedium)
                    ?.copyWith(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              // DESCRIPTION
              Text(
                '     ${SocialMediasLinks().aboutMeOfFlutter}\n\n     ${SocialMediasLinks().aboutMeOfDesigner}',
                style: (isMobile
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodyMedium)
                    ?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 40),

              // SOCIAL BUTTONS
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  runSpacing: 15,
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
              ),

              const SizedBox(height: 50),

              // SKILLS TITLE
              Text(
                'S k i l l s',
                style: (isMobile
                        ? Theme.of(context).textTheme.titleLarge
                        : isTablet
                            ? Theme.of(context).textTheme.headlineSmall
                            : Theme.of(context).textTheme.headlineMedium)
                    ?.copyWith(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              // SKILLS
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget technicalSkillsButton(
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
