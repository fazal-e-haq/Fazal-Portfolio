import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/widgets/responsive_text.dart';
import 'package:fazal_portfolio/core/constants/app_sizes.dart';
import 'package:fazal_portfolio/widgets/button/button_widget.dart';
import 'package:fazal_portfolio/widgets/textfield/neumorphic_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'contact_controller.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final double maxWidth = (isMobile || isTablet)
            ? constraints.maxWidth * 0.95
            : constraints.maxWidth * 0.75;

        return Stack(
          children: [
            // Fixed Background Watermark
            Positioned.fill(
              child: Center(
                child: IgnorePointer(
                  child: RepaintBoundary(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'CONTACT',
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 400,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          letterSpacing: 20,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = isMobile ? 1.5 : 3.0
                            ..color = Colors.white.withValues(alpha: 0.03),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                        horizontal: isMobile ? 16 : 32,
                        vertical: isMobile ? 40 : 80,
                      ),
                      child: (isMobile || isTablet)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(context, isMobile),
                                const SizedBox(height: 40),
                                _buildContactForm(context, isMobile),
                                const SizedBox(height: 40),
                                _buildSocialLinks(context),
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
                                      _buildHeader(context, isMobile),
                                      const SizedBox(height: 60),
                                      _buildSocialLinks(context),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 80),
                                Expanded(
                                  flex: 9,
                                  child: _buildContactForm(context, isMobile),
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

  Widget _buildHeader(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'Get in Touch',
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        ResponsiveText(
          "Have a project in mind or just want to say hi? Feel free to reach out. I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions.",
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
        const SizedBox(height: 24),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _SocialButton(
              title: 'Email Me',
              icon: CupertinoIcons.mail,
              url: 'mailto:fazal.e.haq216@gmail.com',
            ),
            _SocialButton(
              title: 'LinkedIn',
              icon: CupertinoIcons.link,
              url: 'https://www.linkedin.com/in/fazal-e-haq3',
            ),
            _SocialButton(
              title: 'GitHub',
              icon: CupertinoIcons.chevron_left_slash_chevron_right,
              url: 'https://github.com/fazal-e-haq',
            ),
            _SocialButton(
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
    return Container(
      padding: EdgeInsets.all(isMobile ? 32 : 56),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8), // Glassmorphic tint
        borderRadius: BorderRadius.circular(48),
        boxShadow: AppColors.neumorphicShadows(distance: 20, blur: 40),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1.5,
        ),
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
          const SizedBox(height: 24),
          NeumorphicTextField(
            label: 'Email Address',
            icon: CupertinoIcons.mail,
            textController: controller.emailController,
            errorText: controller.emailError,
          ),
          const SizedBox(height: 24),
          NeumorphicTextField(
            label: 'Your Message',
            icon: CupertinoIcons.chat_bubble_text,
            maxLines: 5,
            textController: controller.messageController,
            errorText: controller.messageError,
          ),
          const SizedBox(height: 32),
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
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.title,
    required this.icon,
    required this.url,
  });
  final String title;
  final IconData icon;
  final String url;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
          scale: _isHovered ? 1.15 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutExpo,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isHovered ? theme.primaryColor : AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: _isHovered
                  ? AppColors.neumorphicShadows(
                      distance: 4,
                      blur: 16,
                      glowColor: theme.primaryColor.withValues(alpha: 0.4),
                    )
                  : AppColors.neumorphicShadows(distance: 6, blur: 12),
              border: Border.all(
                color: _isHovered
                    ? theme.primaryColor
                    : Colors.white.withValues(alpha: 0.05),
                width: _isHovered ? 2 : 1,
              ),
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutExpo,
              turns: _isHovered ? -0.05 : 0.0, // slight tilt
              child: Tooltip(
                message: widget.title,
                verticalOffset: 32,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF16181C,
                  ), // Deep dark premium background
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
                  widget.icon,
                  color: _isHovered ? Colors.white : Colors.white70,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
