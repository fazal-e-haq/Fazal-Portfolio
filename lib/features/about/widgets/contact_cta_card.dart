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
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(0), // Sharp angles for sketch
            border: Border.all(
              color: AppColors.textMain,
              width: 2,
            ),
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
                  
                ),
                child: Icon(
                  CupertinoIcons.layers_fill,
                  size: 40,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 32),
              ResponsiveText(
                'Curious What I Can Build?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: isMobile ? 22 : 32, // slightly smaller to fit the longer text better
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 16),
              ResponsiveText(
                "Now that you've seen my skills, journey, and expertise—wondering what I actually build using them? Let's take a look at my recent works.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: isMobile ? 14 : 16,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: isMobile ? double.infinity : 300,
                child: ButtonWidget(
                  id: 'goto_projects_btn',
                  text: const Text(
                    'View My Works',
                    style: TextStyle(
                      color: AppColors.textMain,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.arrow_right, color: AppColors.textMain),
                  color: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: () {
                    Get.find<NavigationController>().setIndex(2); // 2 is Projects page
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
