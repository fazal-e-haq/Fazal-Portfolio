import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../../../widgets/button/button_widget.dart';
import '../../app_shell/navigation_controller.dart';
import '../about_controller.dart';

class ContactCtaCard extends StatelessWidget {
  final bool isMobile;

  const ContactCtaCard({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    const String hoverKey = 'contact_cta_card';
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: Obx(() {
        final bool isHovered = controller.isHovered(hoverKey);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutExpo,
          padding: EdgeInsets.all(isMobile ? 32 : 56),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(isHovered ? 24 : 32),
            border: Border.all(
              color: isHovered ? theme.primaryColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
              width: 2,
            ),
            boxShadow: isHovered
                ? AppColors.neumorphicShadows(
                    distance: 15,
                    blur: 40,
                    glowColor: theme.primaryColor.withValues(alpha: 0.1),
                  )
                : AppColors.neumorphicShadows(distance: 8, blur: 20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: AppColors.neumorphicShadows(distance: 5, blur: 15),
                ),
                child: Icon(
                  CupertinoIcons.paperplane_fill,
                  size: 40,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 32),
              ResponsiveText(
                "Let's Build Something Amazing",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: isMobile ? 24 : 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ResponsiveText(
                "Have a project in mind or want to collaborate? I'm currently open to new opportunities and freelance projects.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: isMobile ? 14 : 16,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: isMobile ? double.infinity : 300,
                child: ButtonWidget(
                  id: 'goto_contact_btn',
                  text: const Text(
                    'Get In Touch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
                  color: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: () {
                    Get.find<NavigationController>().setIndex(3); // 3 is Contact page
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
