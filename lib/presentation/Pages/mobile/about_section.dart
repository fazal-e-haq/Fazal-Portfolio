import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    String aboutMe = dotenv.env['BIO'] ?? 'I am a Flutter Developer and UI/UX Designer...';
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ResponsiveText(
                  'About me',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  minFontSize: 24,
                  maxFontSize: 30,
                ),
                const SizedBox(height: 15),
                ResponsiveText(
                  aboutMe,
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.5, color: Colors.grey),
                  minFontSize: 13,
                  maxFontSize: 15,
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    ButtonWidget(
                      url: linkedin,
                      icon: const Icon(Icons.link, size: 18),
                      child: const Text('LinkedIn', style: TextStyle(fontSize: 12)),
                    ),
                    ButtonWidget(
                      url: github,
                      icon: const Icon(Icons.code, size: 18),
                      child: const Text('GitHub', style: TextStyle(fontSize: 12)),
                    ),
                    ButtonWidget(
                      url: instagram,
                      icon: const Icon(Icons.camera_alt, size: 18),
                      child: const Text('Instagram', style: TextStyle(fontSize: 12)),
                    ),
                    ButtonWidget(
                      url: email,
                      icon: const Icon(Icons.email, size: 18),
                      child: const Text('Email', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: Colors.white10),
                ),
                const ResponsiveText(
                  'Skills',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  minFontSize: 24,
                  maxFontSize: 30,
                ),
                const SizedBox(height: 15),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
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
            ),
          ),
        ),
      ),
    );
  }
}
