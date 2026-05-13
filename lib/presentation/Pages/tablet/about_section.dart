import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

class TabletAboutSection extends StatelessWidget {
  const TabletAboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    String aboutMe = dotenv.env['BIO'] ??
        'I am a Flutter developer with experience in building mobile applications and integrating Firebase for authentication and backend services...';
    String linkedin = dotenv.env['LINKEDIN_URL'] ?? 'https://linkedin.com';
    String github = dotenv.env['GITHUB_URL'] ?? 'https://github.com';
    String instagram = dotenv.env['INSTAGRAM_URL'] ?? 'https://instagram.com';
    String email = dotenv.env['EMAIL_URL'] ?? 'mailto:fazal@example.com';

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool useVertical = constraints.maxWidth < 700;
              
              Widget aboutContent = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: useVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  const ResponsiveText(
                    'About me',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    minFontSize: 28,
                    maxFontSize: 40,
                  ),
                  const SizedBox(height: 20),
                  ResponsiveText(
                    aboutMe,
                    textAlign: useVertical ? TextAlign.center : TextAlign.left,
                    style: const TextStyle(height: 1.4, color: Colors.grey),
                    minFontSize: 13,
                    maxFontSize: 16,
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    alignment: useVertical ? WrapAlignment.center : WrapAlignment.start,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ButtonWidget(url: linkedin, child: const Text('LinkedIn', style: TextStyle(fontSize: 12))),
                      ButtonWidget(url: github, child: const Text('GitHub', style: TextStyle(fontSize: 12))),
                      ButtonWidget(url: instagram, child: const Text('Instagram', style: TextStyle(fontSize: 12))),
                      ButtonWidget(url: email, child: const Text('Email', style: TextStyle(fontSize: 12))),
                    ],
                  ),
                ],
              );

              Widget skillsContent = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ResponsiveText(
                    'Skills',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    minFontSize: 28,
                    maxFontSize: 40,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      SkillsWidget(text: 'Flutter', icon: Icons.flutter_dash, color: Colors.blue),
                      SkillsWidget(text: 'Dart', icon: Icons.code, color: Colors.teal),
                      SkillsWidget(text: 'Figma', icon: Icons.design_services, color: Colors.pinkAccent),
                      SkillsWidget(text: 'Firebase', icon: Icons.local_fire_department, color: Colors.orange),
                      SkillsWidget(text: 'Git', icon: Icons.call_merge, color: Colors.deepOrange),
                      SkillsWidget(text: 'Android Studio', icon: Icons.android, color: Colors.green),
                      SkillsWidget(text: 'Stitch', icon: Icons.api, color: Colors.purple),
                      SkillsWidget(text: 'Antigravity', icon: Icons.rocket_launch, color: Colors.cyan),
                    ],
                  ),
                ],
              );

              if (useVertical) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      aboutContent,
                      const SizedBox(height: 40),
                      skillsContent,
                    ],
                  ),
                );
              } else {
                return Row(
                  children: [
                    Expanded(flex: 5, child: aboutContent),
                    const SizedBox(width: 30),
                    Expanded(flex: 4, child: skillsContent),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
