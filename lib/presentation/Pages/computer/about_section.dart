import 'package:flutter/material.dart';

import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

// This is the About section tailored for computer/desktop users
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Define bio and links directly
    const String aboutMe =
        'I am a Flutter developer with experience in building cross-platform applications with a focus on UI/UX design and state management.';
    const String linkedin = 'https://www.linkedin.com/in/fazal-e-haq3';
    const String github = 'https://github.com/fazal-e-haq';
    const String instagram = 'https://www.instagram.com/code.o.design';
    const String email = 'fazalehaq37405@gmail.com';

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
                      ResponsiveText(
                        'About me',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                            child: Text('LinkedIn'),
                          ),
                          ButtonWidget(
                            url: github,
                            icon: const Icon(Icons.code),
                            child: Text('GitHub'),
                          ),
                          ButtonWidget(
                            url: instagram,
                            icon: const Icon(Icons.camera_alt),
                            child: Text('Instagram'),
                          ),
                          ButtonWidget(
                            url: email,
                            icon: const Icon(Icons.email),
                            child: Text('Email'),
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
                      ResponsiveText(
                        'Skills',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                          SkillsWidget(
                            text: 'Flutter',
                            icon: Icons.flutter_dash,
                            color: Colors.blue,
                          ),
                          SkillsWidget(
                            text: 'Dart',
                            icon: Icons.code,
                            color: Colors.teal,
                          ),
                          SkillsWidget(
                            text: 'Android Studio',
                            icon: Icons.android,
                            color: Colors.green,
                          ),
                          SkillsWidget(
                            text: 'Figma',
                            icon: Icons.design_services,
                            color: Colors.pinkAccent,
                          ),
                          SkillsWidget(
                            text: 'Firebase',
                            icon: Icons.local_fire_department,
                            color: Colors.orange,
                          ),
                          SkillsWidget(
                            text: 'Git',
                            icon: Icons.call_merge,
                            color: Colors.deepOrange,
                          ),

                          SkillsWidget(
                            text: 'Stitch',
                            icon: Icons.api,
                            color: Colors.purple,
                          ),
                          SkillsWidget(
                            text: 'Antigravity',
                            icon: Icons.rocket_launch,
                            color: Colors.cyan,
                          ),
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
