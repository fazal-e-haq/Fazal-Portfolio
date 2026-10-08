import 'package:flutter/cupertino.dart';
import '../../widgets/button/button_widget.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/themes/theme.dart';
import '../../widgets/animations/fade_in_up_widget.dart';
import '../../widgets/sketch_card.dart';
import '../../widgets/textfield/neumorphic_textfield.dart';
import 'contact_controller.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800), // Narrower for contact form
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 40 : 0)),
              child: isMobile ? const _MobileContact() : const _DesktopContact(),
            ),
          ),
        );
      },
    );
  }
}

class _DesktopContact extends StatelessWidget {
  const _DesktopContact();

  @override
  Widget build(BuildContext context) {
    return FadeInUpWidget(
      delay: const Duration(milliseconds: 200),
      child: SketchCard(
        padding: const EdgeInsets.all(56),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.paperplane_fill, size: 48, color: AppColors.primary),
            const SizedBox(height: 24),
            const Text(
              "Let's Build Something",
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Have an idea? I'd love to help you bring it to life. Drop a message below and I'll get back to you within 24 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 48),
            _ContactForm(),
          ],
        ),
      ),
    );
  }
}

class _MobileContact extends StatelessWidget {
  const _MobileContact();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 60),
          FadeInUpWidget(
            delay: const Duration(milliseconds: 200),
            child: SketchCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.paperplane_fill, size: 36, color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text(
                    "Let's Connect",
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Have an idea? Drop a message below and I'll get back to you shortly.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _ContactForm(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      );
  }
}

class _ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: NeumorphicTextField(
                controller: contactController.nameController,
                hintText: 'Your Name',
                icon: CupertinoIcons.person,
                errorText: contactController.nameError,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: NeumorphicTextField(
                controller: contactController.emailController,
                hintText: 'Email Address',
                icon: CupertinoIcons.mail,
                errorText: contactController.emailError,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        NeumorphicTextField(
          controller: contactController.messageController,
          hintText: 'Tell me about your project...',
          icon: CupertinoIcons.chat_bubble_text,
          maxLines: 4,
          errorText: contactController.messageError,
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 240,
          height: 56,
          child: ButtonWidget(
            id: 'contact_submit_btn',
            onPressed: () {
              contactController.sendEmail();
            },
            text: const Text(
              'Send Message',
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textMain,
              ),
            ),
            icon: const Icon(CupertinoIcons.paperplane, size: 18, color: AppColors.textMain),
          ),
        ),
      ],
    );
  }
}






