import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

// This is the About section tailored for tablet devices
class TabletAboutSection extends StatelessWidget {
  const TabletAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Load bio and links from environment variables
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
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: InfoCardWidget(
            width: size.width * 0.9,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // If the tablet is in portrait or narrow, use vertical layout
                bool useVertical = constraints.maxWidth < 700;
                
                // Content for the "About" side
                Widget aboutContent = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: useVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    const ResponsiveText(
                      'About me',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      minFontSize: 28,
                      maxFontSize: 36,
                    ),
                    const SizedBox(height: 15),
                    ResponsiveText(
                      aboutMe,
                      textAlign: useVertical ? TextAlign.center : TextAlign.left,
                      style: const TextStyle(height: 1.4, color: Colors.grey),
                      minFontSize: 13,
                      maxFontSize: 16,
                    ),
                    const SizedBox(height: 20),
                    // Intermediate sized social buttons
                    Wrap(
                      alignment: useVertical ? WrapAlignment.center : WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        _buildTabletSocialButton(linkedin, Icons.link, 'LinkedIn'),
                        _buildTabletSocialButton(github, Icons.code, 'GitHub'),
                        _buildTabletSocialButton(instagram, Icons.camera_alt, 'Instagram'),
                        _buildTabletSocialButton(email, Icons.email, 'Email'),
                      ],
                    ),
                  ],
                );

                // Content for the "Skills" side
                Widget skillsContent = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ResponsiveText(
                      'Skills',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      minFontSize: 28,
                      maxFontSize: 36,
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        // Skills with intermediate sizes for tablet
                        SkillsWidget(text: 'Flutter', icon: Icons.flutter_dash, color: Colors.blue, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Dart', icon: Icons.code, color: Colors.teal, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Figma', icon: Icons.design_services, color: Colors.pinkAccent, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Firebase', icon: Icons.local_fire_department, color: Colors.orange, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Git', icon: Icons.call_merge, color: Colors.deepOrange, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Android Studio', icon: Icons.android, color: Colors.green, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Stitch', icon: Icons.api, color: Colors.purple, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                        SkillsWidget(text: 'Antigravity', icon: Icons.rocket_launch, color: Colors.cyan, fontSize: 15, iconSize: 24, horizontalPadding: 16, verticalPadding: 8),
                      ],
                    ),
                  ],
                );

                if (useVertical) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        aboutContent,
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Divider(color: Colors.white10),
                        ),
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
      ),
    );
  }

  // Helper for tablet social buttons
  Widget _buildTabletSocialButton(String url, IconData icon, String label) {
    return ButtonWidget(
      url: url,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      icon: Icon(icon, size: 16),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}
