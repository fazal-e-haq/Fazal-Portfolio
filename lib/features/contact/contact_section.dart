import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/widgets/responsive_text.dart';
import 'package:fazal_portfolio/core/constants/app_sizes.dart';
import 'package:fazal_portfolio/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: isMobile ? 40 : 80,
                ),
                child: isMobile
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(context, isMobile),
                                const SizedBox(height: 60),
                                _buildSocialLinks(context),
                              ],
                            ),
                          ),
                          SizedBox(width: isTablet ? 40 : 80),
                          Expanded(
                            flex: 6,
                            child: _buildContactForm(context, isMobile),
                          ),
                        ],
                      ),
              ),
            ),
          ),
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
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: theme.primaryColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontFamily: 'Unbounded',
          ),
        ),
        const SizedBox(height: 8),
        ResponsiveText(
          'Contact Me',
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
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
        const Row(
          children: [
            _SocialButton(
              icon: CupertinoIcons.mail,
              url: 'mailto:contact@fazal.dev',
            ),
            SizedBox(width: 16),
            _SocialButton(
              icon: CupertinoIcons.link,
              url: 'https://linkedin.com',
            ),
            SizedBox(width: 16),
            _SocialButton(
              icon: CupertinoIcons.chevron_left_slash_chevron_right,
              url: 'https://github.com',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppColors.neumorphicShadows(distance: 8, blur: 16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.03),
          width: 1,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NeomorphicInput(label: 'Your Name', icon: CupertinoIcons.person),
          SizedBox(height: 24),
          _NeomorphicInput(label: 'Email Address', icon: CupertinoIcons.mail),
          SizedBox(height: 24),
          _NeomorphicInput(
            label: 'Your Message', 
            icon: CupertinoIcons.chat_bubble_text, 
            maxLines: 5,
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              url: 'mailto:contact@fazal.dev?subject=New%20Message%20from%20Portfolio',
              icon: Icon(CupertinoIcons.paperplane_fill, color: Colors.white),
              text: Text(
                'Send Message',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeomorphicInput extends StatelessWidget {
  const _NeomorphicInput({
    required this.label,
    required this.icon,
    this.maxLines = 1,
  });

  final String label;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceInner,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              // Inner shadow simulation for depressed look
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                offset: const Offset(insetDistance, insetDistance),
                blurRadius: insetBlur,
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.02),
                offset: const Offset(-insetDistance, -insetDistance),
                blurRadius: insetBlur,
              ),
            ],
          ),
          child: TextField(
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
              prefixIcon: maxLines == 1 
                  ? Icon(icon, color: AppColors.primary.withValues(alpha: 0.5)) 
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Icon(icon, color: AppColors.primary.withValues(alpha: 0.5)),
                    ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  static const double insetDistance = 3.0;
  static const double insetBlur = 6.0;
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered ? theme.primaryColor : AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: AppColors.neumorphicShadows(
              isPressed: _isHovered,
              distance: _isHovered ? 2 : 6,
              blur: _isHovered ? 4 : 12,
              glowColor: _isHovered ? theme.primaryColor : null,
            ),
            border: Border.all(
              color: _isHovered 
                  ? theme.primaryColor 
                  : Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? Colors.white : Colors.white70,
            size: 24,
          ),
        ),
      ),
    );
  }
}
