import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_Widget.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    String aboutMe =
        'I am a Flutter developer with experience in building mobile applications and integrating Firebase for authentication and backend services. I use Provider for state management to keep apps scalable and maintainable.\n           Alongside coding, I also design clean and user-friendly interfaces as a UI/UX designer. I am eager to learn, grow, and contribute to impactful projects and internship opportunities.';

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.76,
          height: size.height * 0.62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About me',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      'I am a Flutter Developer and UI/UX Designer',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: size.height * 0.025),
                    Text(aboutMe, style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          onPressed: () {},
                          icon: const Icon(Icons.person_pin),
                          child: const Text('LinkedIn'),
                        ),
                        const SizedBox(width: 10),
                        ButtonWidget(
                          onPressed: () {},
                          icon: const Icon(Icons.person_pin),
                          child: const Text('LinkedIn'),
                        ),
                        const SizedBox(width: 10),
                        ButtonWidget(
                          onPressed: () {},
                          icon: const Icon(Icons.person_pin),
                          child: const Text('LinkedIn'),
                        ),
                        const SizedBox(width: 10),
                        ButtonWidget(
                          onPressed: () {},
                          icon: const Icon(Icons.person_pin),
                          child: const Text('LinkedIn'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '          Skills',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    children: [
                      const SkillsWidget(
                        text: 'Flutter',
                        icon: Icon(Icons.person, size: 30),
                      ),
                      const SkillsWidget(
                        text: 'Figma',
                        icon: Icon(Icons.person, size: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SkillsWidget(
                        text: 'Firebase',
                        icon: Icon(Icons.person, size: 30),
                      ),
                      const SkillsWidget(
                        text: 'Dart',
                        icon: Icon(Icons.person, size: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SkillsWidget(
                        text: 'Git',
                        icon: Icon(Icons.person, size: 30),
                      ),
                      const SkillsWidget(
                        text: 'Android Studio',
                        icon: Icon(Icons.person, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
