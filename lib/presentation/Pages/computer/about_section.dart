import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

// This is the About section tailored for computer/desktop users
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the bio and social links from the .env file (or use defaults)
    String aboutMe = dotenv.env['BIO'] ?? 'I am a Flutter developer with experience...';
    String linkedin = dotenv.env['LINKEDIN_URL'] ?? 'https://linkedin.com';
    String github = dotenv.env['GITHUB_URL'] ?? 'https://github.com';
    String instagram = dotenv.env['INSTAGRAM_URL'] ?? 'https://instagram.com';
    String email = dotenv.env['EMAIL_URL'] ?? 'mailto:fazal@example.com';

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: child,
              ),
            );
          },
          child: InfoCardWidget(
            width: size.width * 0.85, // Use more width on desktop
            height: size.height * 0.75, // Responsive height based on screen
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side: "About me" text and social buttons
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveText(
                        'About me',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        minFontSize: 30,
                        maxFontSize: 60,
                        scaleFactor: 0.04,
                      ),
                      SizedBox(height: size.height * 0.04),
                      const ResponsiveText(
                        'I am a Flutter Developer and UI/UX Designer',
                        style: TextStyle(fontWeight: FontWeight.w500),
                        minFontSize: 18,
                        maxFontSize: 28,
                      ),
                      SizedBox(height: size.height * 0.02),
                      ResponsiveText(
                        aboutMe,
                        style: const TextStyle(height: 1.5, color: Colors.grey),
                        minFontSize: 14,
                        maxFontSize: 20,
                      ),
                      SizedBox(height: size.height * 0.03),
                      Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 15,
                        spacing: 15,
                        children: [
                          ButtonWidget(
                            url: linkedin,
                            icon: const Icon(Icons.link),
                            child: const Text('LinkedIn'),
                          ),
                          ButtonWidget(
                            url: github,
                            icon: const Icon(Icons.code),
                            child: const Text('GitHub'),
                          ),
                          ButtonWidget(
                            url: instagram,
                            icon: const Icon(Icons.camera_alt),
                            child: const Text('Instagram'),
                          ),
                          ButtonWidget(
                            url: email,
                            icon: const Icon(Icons.email),
                            child: const Text('Email'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                // Right side: "Skills" list
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ResponsiveText(
                        'Skills',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        minFontSize: 30,
                        maxFontSize: 60,
                        scaleFactor: 0.04,
                      ),
                      SizedBox(height: size.height * 0.04),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
