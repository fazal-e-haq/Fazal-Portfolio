import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

// This is the About section tailored for mobile devices
class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Load bio and links from environment variables
    String aboutMe = dotenv.env['BIO'] ?? 'I am a Flutter Developer and UI/UX Designer...';
    String linkedin = dotenv.env['LINKEDIN_URL'] ?? 'https://linkedin.com';
    String github = dotenv.env['GITHUB_URL'] ?? 'https://github.com';
    String instagram = dotenv.env['INSTAGRAM_URL'] ?? 'https://instagram.com';
    String email = dotenv.env['EMAIL_URL'] ?? 'mailto:fazal@example.com';

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      // Add padding to prevent touching other sections too closely
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: InfoCardWidget(
            width: size.width * 0.92,
            // Use smaller padding for mobile to save space
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(), // Content should fit within the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ResponsiveText(
                    'About me',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    minFontSize: 22,
                    maxFontSize: 26,
                  ),
                  const SizedBox(height: 10),
                  ResponsiveText(
                    aboutMe,
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.4, color: Colors.grey),
                    minFontSize: 12,
                    maxFontSize: 14,
                  ),
                  const SizedBox(height: 15),
                  // Social buttons with smaller padding and font
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      _buildMobileSocialButton(linkedin, Icons.link, 'LinkedIn'),
                      _buildMobileSocialButton(github, Icons.code, 'GitHub'),
                      _buildMobileSocialButton(instagram, Icons.camera_alt, 'Instagram'),
                      _buildMobileSocialButton(email, Icons.email, 'Email'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.white10, height: 1),
                  ),
                  const ResponsiveText(
                    'Skills',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    minFontSize: 22,
                    maxFontSize: 26,
                  ),
                  const SizedBox(height: 10),
                  // Skills with smaller sizes for mobile
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    runSpacing: 6,
                    children: const [
                      SkillsWidget(text: 'Flutter', icon: Icons.flutter_dash, color: Colors.blue, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Dart', icon: Icons.code, color: Colors.teal, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Figma', icon: Icons.design_services, color: Colors.pinkAccent, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Firebase', icon: Icons.local_fire_department, color: Colors.orange, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Git', icon: Icons.call_merge, color: Colors.deepOrange, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Android Studio', icon: Icons.android, color: Colors.green, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Stitch', icon: Icons.api, color: Colors.purple, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                      SkillsWidget(text: 'Antigravity', icon: Icons.rocket_launch, color: Colors.cyan, fontSize: 13, iconSize: 20, horizontalPadding: 12, verticalPadding: 6),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper for small social buttons on mobile
  Widget _buildMobileSocialButton(String url, IconData icon, String label) {
    return ButtonWidget(
      url: url,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      icon: Icon(icon, size: 14),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }
}
