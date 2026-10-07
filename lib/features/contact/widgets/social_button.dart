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
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textMain,
                  width: 2,
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
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColors.textMain,
                      width: 2,
                    ),
                  ),
                  textStyle: const TextStyle(
                    color: AppColors.textMain,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                  child: Icon(
                    icon,
                    color: isHovered ? AppColors.textMain : AppColors.textMain.withValues(alpha: 0.70),
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
