import 'package:flutter/material.dart';

import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/skills_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';

import '../../../core/constants/social_medias_links.dart';

// This is the About section tailored for mobile devices
class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Define bio and links directly
    final socialLinks = SocialMediasLinks();

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
                    ResponsiveText(
                    'About me',
                    style: Theme.of(context).textTheme.headlineMedium,
                    minFontSize: 22,
                    maxFontSize: 26,
                  ),
                  const SizedBox(height: 10),
                  ResponsiveText(
                    '${socialLinks.aboutMeOfFlutter}\n\n ${socialLinks.aboutMeOfDesigner}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.4, color: Colors.grey),
                    minFontSize: 12,
                    maxFontSize: 14,
                  ),
                  const SizedBox(height: 15),
                  // Social buttons with smaller padding and font
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 7,
                    spacing: 7,
                    children: [
                      _buildMobileSocialButton( socialLinks.linkedinAccountLink, Icons.link, 'LinkedIn'),
                      _buildMobileSocialButton( socialLinks.githubAccountLink, Icons.code, 'GitHub'),
                      _buildMobileSocialButton(socialLinks.instagramAccountLink, Icons.camera_alt, 'Instagram'),
                      _buildMobileSocialButton(socialLinks.emailAccountLink, Icons.email, 'Email'),
                    ],
                  ),
                  // Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.white10, height: 1),
                  ),
                    ResponsiveText(
                    'Skills',
                    style: Theme.of(context).textTheme.headlineMedium,
                    minFontSize: 22,
                    maxFontSize: 26,
                  ),
                  const SizedBox(height: 10),
                  // Skills with smaller sizes for mobile
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      SkillsWidget(text: 'Flutter', icon: Icons.flutter_dash, color: Colors.blue, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Dart', icon: Icons.code, color: Colors.teal, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Figma', icon: Icons.design_services, color: Colors.pinkAccent, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Firebase', icon: Icons.local_fire_department, color: Colors.orange, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Git', icon: Icons.call_merge, color: Colors.deepOrange, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Android Studio', icon: Icons.android, color: Colors.green, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Stitch', icon: Icons.api, color: Colors.purple, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
                      SkillsWidget(text: 'Antigravity', icon: Icons.rocket_launch, color: Colors.cyan, fontSize: 11, iconSize: 15, horizontalPadding: 10, verticalPadding: 5),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      icon: Icon(icon, size: 14),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
