import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Tooltip;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/social_medias_links.dart';
import '../../core/themes/theme.dart';
import '../../services/analytics_service.dart';
import '../../widgets/animations/fade_in_up_widget.dart';
import '../../widgets/button/sketch_button.dart';
import '../../widgets/inputs/sketch_text_field.dart';
import '../../widgets/sketch_card.dart';
import '../../widgets/sketch_painter.dart';
import 'contact_controller.dart';

/// Full-width, ultra-premium Contact Section designed in Hand-Drawn Brutalism.
///
/// Features:
/// - Editorial Two-Column Layout on Desktop & Tablet:
///   - Left Column: "Get in Touch" header with hand-drawn sketch divider line, narrative,
///     and outlined social icons that tilt on hover with smooth spring physics.
///   - Right Column: Hand-drawn Contact Form with character counter and dynamic sketch send button.
/// - Responsive single-column flow on Mobile with fluid touch interaction.
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ContactController>()) {
      Get.put(ContactController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 980;
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : (isTablet ? 32.0 : 64.0),
              ),
              child: isCompact
                  ? const _MobileContact()
                  : const _DesktopContact(),
            ),
          ),
        );
      },
    );
  }
}

/// Desktop & Tablet Two-Column Editorial Contact Grid.
class _DesktopContact extends StatelessWidget {
  const _DesktopContact();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Get in touch, line, narrative & outlined tilt icons
        Expanded(
          flex: 5,
          child: FadeInUpWidget(
            delay: Duration(milliseconds: 180),
            child: _LeftColumnGetInTouch(isMobile: false),
          ),
        ),
        SizedBox(width: 48),

        // Right Column: Message Form
        Expanded(
          flex: 6,
          child: FadeInUpWidget(
            delay: Duration(milliseconds: 320),
            child: _ContactFormCard(isMobile: false),
          ),
        ),
      ],
    );
  }
}

/// Mobile Single-Column Flow with full touch responsiveness.
class _MobileContact extends StatelessWidget {
  const _MobileContact();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUpWidget(
          delay: Duration(milliseconds: 180),
          child: _LeftColumnGetInTouch(isMobile: true),
        ),
        SizedBox(height: 36),
        FadeInUpWidget(
          delay: Duration(milliseconds: 300),
          child: _ContactFormCard(isMobile: true),
        ),
      ],
    );
  }
}

/// Left Column: "Get in Touch" heading, hand-drawn line, narrative copy,
/// and outlined social icons that tilt dynamically on hover.
class _LeftColumnGetInTouch extends StatelessWidget {
  final bool isMobile;

  const _LeftColumnGetInTouch({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final socials = SocialMediasLinks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Get In Touch" main title
        Text(
          'Get in Touch',
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: isMobile ? 36 : 46,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 10),

        // Hand-drawn sketch divider line
        const SketchDivider(
          width: 150,
          height: 6,
          strokeWidth: 2.2,
          seed: 39,
        ),
        const SizedBox(height: 20),

        // Narrative copy
        const Text(
          'Have a project in mind or just want to say hi? Drop me a message or connect with me on social media—I’d love to chat!',
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 17,
            color: AppColors.textSecondary,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 28),

        // Subtitle for social icons
        const Text(
          'CONNECT ACROSS PLATFORMS',
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),

        // Outlined Social Icons with Tilt Animation on Hover
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            const _OutlinedTiltSocialButton(
              title: 'Email',
              icon: CupertinoIcons.mail_solid,
              url: 'mailto:fazalehaq37405@gmail.com',
              seed: 41,
              tiltTurn: -0.05,
            ),
            _OutlinedTiltSocialButton(
              title: 'LinkedIn',
              icon: CupertinoIcons.link,
              url: socials.linkedinAccountLink,
              seed: 47,
              tiltTurn: 0.05,
            ),
            _OutlinedTiltSocialButton(
              title: 'GitHub',
              icon: CupertinoIcons.chevron_left_slash_chevron_right,
              url: socials.githubAccountLink,
              seed: 53,
              tiltTurn: -0.05,
            ),
            _OutlinedTiltSocialButton(
              title: 'Instagram',
              icon: CupertinoIcons.camera_fill,
              url: socials.instagramAccountLink,
              seed: 59,
              tiltTurn: 0.05,
            ),
          ],
        ),
      ],
    );
  }
}

/// Outlined social icon button that tilts dynamically on hover like the previous portfolio design.
class _OutlinedTiltSocialButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final String url;
  final int seed;
  final double tiltTurn;

  const _OutlinedTiltSocialButton({
    required this.title,
    required this.icon,
    required this.url,
    required this.seed,
    this.tiltTurn = -0.05,
  });

  @override
  State<_OutlinedTiltSocialButton> createState() =>
      _OutlinedTiltSocialButtonState();
}

class _OutlinedTiltSocialButtonState extends State<_OutlinedTiltSocialButton> {
  bool _isHovered = false;

  Future<void> _launch() async {
    AnalyticsService.logEvent('social_channel_click', {
      'platform': widget.title,
      'url': widget.url,
    });

    final Uri uri = Uri.parse(widget.url);
    try {
      final isMailto = uri.scheme == 'mailto';
      if (isMailto) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.title,
      verticalOffset: 38,
      decoration: SketchTooltipDecoration(
        backgroundColor: AppColors.background,
        borderColor: AppColors.textMain,
        strokeWidth: 1.9,
        borderRadius: 10.0,
        wobble: 1.5,
        seed: widget.seed,
      ),
      textStyle: const TextStyle(
        fontFamily: 'Patrick Hand',
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: AppColors.textMain,
        letterSpacing: 0.8,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _launch,
          behavior: HitTestBehavior.opaque,
          child: AnimatedScale(
            scale: _isHovered ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutBack,
            child: AnimatedRotation(
              turns: _isHovered ? widget.tiltTurn : 0.0,
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutBack,
              child: SizedBox(
                width: 58,
                height: 58,
                child: CustomPaint(
                  painter: SketchBorderPainter(
                    color: _isHovered
                        ? AppColors.textMain
                        : AppColors.textMain.withValues(alpha: 0.75),
                    strokeWidth: _isHovered ? 2.4 : 1.8,
                    borderRadius: 18.0,
                    wobble: 1.6,
                    seed: widget.seed,
                    backgroundColor: AppColors.background,
                    isHovered: _isHovered,
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      size: 26,
                      color: _isHovered
                          ? AppColors.primary
                          : AppColors.textMain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Right Column: Message Form with character count and send button.
class _ContactFormCard extends StatelessWidget {
  final bool isMobile;

  const _ContactFormCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();

    final nameField = SketchTextField(
      controller: contactController.nameController,
      hintText: 'Your Name',
      icon: CupertinoIcons.person,
      errorText: contactController.nameError,
    );

    final emailField = SketchTextField(
      controller: contactController.emailController,
      hintText: 'Email Address',
      icon: CupertinoIcons.mail,
      errorText: contactController.emailError,
    );

    return SketchCard(
      seed: 47,
      enableHover: false,
      padding: EdgeInsets.all(isMobile ? 24.0 : 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CustomPaint(
                painter: SketchBorderPainter(
                  strokeWidth: 1.8,
                  borderRadius: 14,
                  wobble: 1.5,
                  seed: 77,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    CupertinoIcons.paperplane_fill,
                    size: 26,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send a Message',
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textMain,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 4),
                    SketchDivider(
                      width: 140,
                      height: 6,
                      strokeWidth: 1.8,
                      seed: 79,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Tell me about your project, idea, or questions.',
            style: TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 24),

          // Responsive Form Fields
          if (isMobile) ...[
            nameField,
            const SizedBox(height: 14),
            emailField,
          ] else
            Row(
              children: [
                Expanded(child: nameField),
                const SizedBox(width: 20),
                Expanded(child: emailField),
              ],
            ),
          const SizedBox(height: 18),

          // Message Field with Character Counter
          _MessageFieldWithCounter(controller: contactController),
          const SizedBox(height: 26),

          // Submit Button & Privacy Assurance
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => SketchButton(
                    id: 'contact_submit_btn',
                    onPressed: contactController.isSending
                        ? null
                        : () => contactController.sendEmail(),
                    icon: Icon(
                      contactController.isSending
                          ? CupertinoIcons.arrow_2_circlepath
                          : CupertinoIcons.paperplane_fill,
                      size: 18,
                      color: AppColors.textMain,
                    ),
                    text: Text(
                      contactController.isSending
                          ? 'SENDING...'
                          : 'SEND MESSAGE',
                      style: const TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: AppColors.textMain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Message input field with dynamic character counter.
class _MessageFieldWithCounter extends StatefulWidget {
  final ContactController controller;

  const _MessageFieldWithCounter({required this.controller});

  @override
  State<_MessageFieldWithCounter> createState() =>
      _MessageFieldWithCounterState();
}

class _MessageFieldWithCounterState extends State<_MessageFieldWithCounter> {
  int _charCount = 0;
  static const int _maxChars = 800;

  @override
  void initState() {
    super.initState();
    _charCount = widget.controller.messageController.text.length;
    widget.controller.messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.messageController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        _charCount = widget.controller.messageController.text.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SketchTextField(
          controller: widget.controller.messageController,
          hintText:
              'Describe your project goals, timelines, or ask any question...',
          icon: CupertinoIcons.chat_bubble_text,
          maxLines: 5,
          errorText: widget.controller.messageError,
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$_charCount / $_maxChars characters',
            style: TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 12,
              color: _charCount > _maxChars
                  ? Colors.redAccent.shade700
                  : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
