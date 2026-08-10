import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/widgets/responsive_text.dart';
import 'package:fazal_portfolio/core/constants/app_sizes.dart';
import 'package:fazal_portfolio/widgets/button/button_widget.dart';
import 'package:fazal_portfolio/widgets/textfield/neumorphic_textfield.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/widgets/textfield/textfield_controller.dart';
import 'package:fazal_portfolio/widgets/animations/fade_in_up_widget.dart';
import 'package:fazal_portfolio/widgets/section_background_text.dart';
import 'contact_controller.dart';
import 'widgets/social_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController()); // Initialize controller

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final bool isUltrawide = AppSizes.isUltrawide(constraints);
        final double maxWidth = (isMobile || isTablet)
            ? double.infinity
            : (isUltrawide ? 1100 : constraints.maxWidth * 0.75);

        return Stack(
          children: [
            // Fixed Background Watermark
            const Positioned.fill(
              child: SectionBackgroundText(text: 'CONTACT'),
            ),

            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : (isTablet ? 26 : (isUltrawide ? 64 : 32)),
                        vertical: isMobile ? 120 : (isUltrawide ? 200 : 140), // Increased significantly to clear AppBar and center content vertically
                      ),
                      child: (isMobile || isTablet)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInUpWidget(
                                  delay: const Duration(milliseconds: 200),
                                  child: _buildHeader(context, isMobile, isTablet),
                                ),
                                const SizedBox(height: 40),
                                FadeInUpWidget(
                                  delay: const Duration(milliseconds: 400),
                                  child: _buildContactForm(context, isMobile),
                                ),
                                const SizedBox(height: 40),
                                FadeInUpWidget(
                                  delay: const Duration(milliseconds: 600),
                                  child: _buildSocialLinks(context),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FadeInUpWidget(
                                        delay: const Duration(milliseconds: 200),
                                        child: _buildHeader(context, isMobile, isTablet),
                                      ),
                                      const SizedBox(height: 60),
                                      FadeInUpWidget(
                                        delay: const Duration(milliseconds: 400),
                                        child: _buildSocialLinks(context),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 80),
                                Expanded(
                                  flex: 7, // Reduced from 9 to make form smaller
                                  child: FadeInUpWidget(
                                    delay: const Duration(milliseconds: 500),
                                    child: _buildContactForm(context, isMobile),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile, bool isTablet) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'Get in Touch',
              speed: const Duration(milliseconds: 150),
              textStyle: theme.textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                color: theme.primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ResponsiveText(
          "Every great project starts with a simple conversation. If you have an idea, a question, or an opportunity in mind, I'd be delighted to hear from you and see how I can help.",
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.8,
            fontSize: isMobile ? 14 : 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'Connect with me',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ResponsiveText(
          "Not ready to reach out just yet? Feel free to explore my social profiles and see what I've been working on.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.6,
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SocialButton(
              title: 'Email Me',
              icon: CupertinoIcons.mail,
              url: 'mailto:fazal.e.haq216@gmail.com',
            ),
            SocialButton(
              title: 'LinkedIn',
              icon: CupertinoIcons.link,
              url: 'https://www.linkedin.com/in/fazal-e-haq3',
            ),
            SocialButton(
              title: 'GitHub',
              icon: CupertinoIcons.chevron_left_slash_chevron_right,
              url: 'https://github.com/fazal-e-haq',
            ),
            SocialButton(
              title: 'Instagram',
              icon: CupertinoIcons.camera,
              url: 'https://www.instagram.com/fazalehaq.dev',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
    final controller = Get.find<ContactController>();
    final tfController = Get.find<TextFieldController>();
    const String hoverKey = 'contact_form_container';

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: Obx(() {
        final isHovered = controller.isHovered(hoverKey);
        final isAnyFieldActive = tfController.isAnyActive;
        final isActive = isHovered || isAnyFieldActive;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutExpo,
          padding: EdgeInsets.all(isMobile ? 24 : 40), // Reduced padding for desktop
          decoration: BoxDecoration(
            color: isActive ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(isActive ? 16 : 24),
            border: Border.all(
              color: isActive ? AppColors.primary.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.03),
              width: 1,
            ),
            boxShadow: isActive ? AppColors.neumorphicShadows(distance: 20, blur: 40, glowColor: AppColors.primary.withValues(alpha: 0.05)) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          NeumorphicTextField(
            label: 'Your Name', 
            icon: CupertinoIcons.person,
            textController: controller.nameController,
            errorText: controller.nameError,
          ),
          SizedBox(height: isMobile ? 16 : 24), // Reduced margin
          NeumorphicTextField(
            label: 'Email Address',
            icon: CupertinoIcons.mail,
            textController: controller.emailController,
            errorText: controller.emailError,
          ),
          SizedBox(height: isMobile ? 16 : 24), // Reduced margin
          NeumorphicTextField(
            label: 'Your Message',
            icon: CupertinoIcons.chat_bubble_text,
            maxLines: 5,
            textController: controller.messageController,
            errorText: controller.messageError,
          ),
          SizedBox(height: isMobile ? 24 : 32), // Reduced margin
          SizedBox(
            width: double.infinity,
            child: Obx(() => ButtonWidget(
              id: 'send_btn',
              onPressed: controller.isSending ? null : () => controller.sendEmail(),
              icon: controller.isSending 
                  ? const Icon(CupertinoIcons.circle, color: Colors.white) 
                  : const Icon(CupertinoIcons.paperplane_fill, color: Colors.white),
              text: Text(
                controller.isSending ? 'Sending...' : 'Send Message',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              color: AppColors.primary,
            )),
          ),
        ],
      ),
    );
      }),
    );
  }
}
