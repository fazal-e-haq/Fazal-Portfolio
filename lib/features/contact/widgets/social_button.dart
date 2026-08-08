import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/themes/theme.dart';
import '../contact_controller.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.title,
    required this.icon,
    required this.url,
  });

  final String title;
  final IconData icon;
  final String url;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    try {
      final isMailto = uri.scheme == 'mailto';
      if (isMailto) {
        final email = uri.path;
        final gmailUri = Uri.https('mail.google.com', '/mail/', {
          'view': 'cm',
          'fs': '1',
          'to': email,
        });
        await launchUrl(
          gmailUri,
          mode: LaunchMode.externalApplication,
        );
        return;
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } catch (e) {
      debugPrint('Error launching url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<ContactController>();
    final String hoverKey = 'social_btn_$title';

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: Obx(() {
          final bool isHovered = controller.isHovered(hoverKey);

          return AnimatedScale(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutExpo,
            scale: isHovered ? 1.15 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutExpo,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isHovered ? theme.primaryColor : AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: isHovered
                    ? AppColors.neumorphicShadows(
                        distance: 4,
                        blur: 16,
                        glowColor: theme.primaryColor.withValues(alpha: 0.4),
                      )
                    : AppColors.neumorphicShadows(distance: 6, blur: 12),
                border: Border.all(
                  color: isHovered
                      ? theme.primaryColor
                      : Colors.white.withValues(alpha: 0.05),
                  width: isHovered ? 2 : 1,
                ),
              ),
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutExpo,
                turns: isHovered ? -0.05 : 0.0,
                child: Tooltip(
                  message: title,
                  verticalOffset: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16181C),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(-2, -2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                      width: 1,
                    ),
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                  child: Icon(
                    icon,
                    color: isHovered ? Colors.white : Colors.white70,
                    size: 28,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
