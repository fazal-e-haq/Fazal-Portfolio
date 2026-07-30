import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/widgets/responsive_text.dart';
import 'package:fazal_portfolio/core/constants/app_sizes.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
                          _buildBioSection(context, isMobile),
                          const SizedBox(height: 60),
                          _buildSkillsSection(context, isMobile),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _buildBioSection(context, isMobile),
                          ),
                          SizedBox(width: isTablet ? 40 : 80),
                          Expanded(
                            flex: 4,
                            child: _buildSkillsSection(context, isMobile),
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

  Widget _buildBioSection(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'Discover',
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
          'About Me',
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: AppColors.neumorphicShadows(distance: 8, blur: 16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.03),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.text_quote,
                color: theme.primaryColor.withValues(alpha: 0.5),
                size: 32,
              ),
              const SizedBox(height: 20),
              ResponsiveText(
                'I am a passionate Flutter Developer and UI/UX Designer dedicated to crafting stunning, high-performance applications. With a strong eye for detail and a deep understanding of modern Neomorphic design principles, I build seamless cross-platform experiences that users love.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  fontSize: isMobile ? 14 : 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              ResponsiveText(
                "Whether it's bringing complex architectures to life in Dart or pixel-perfecting a beautiful interface in Figma, my goal is always to deliver a 10/10 premium digital product.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  fontSize: isMobile ? 14 : 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'My Arsenal',
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
          'Skills & Tools',
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 24 : 36,
          ),
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _SkillCard(icon: CupertinoIcons.device_phone_portrait, name: 'Flutter'),
            _SkillCard(icon: CupertinoIcons.chevron_left_slash_chevron_right, name: 'Dart'),
            _SkillCard(icon: CupertinoIcons.paintbrush, name: 'UI/UX'),
            _SkillCard(icon: CupertinoIcons.cloud, name: 'Firebase'),
            _SkillCard(icon: CupertinoIcons.layers_alt, name: 'Figma'),
            _SkillCard(icon: CupertinoIcons.rocket, name: 'Animation'),
          ],
        ),
      ],
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.icon, required this.name});
  
  final IconData icon;
  final String name;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceInner : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.neumorphicShadows(
            isPressed: _isHovered, // Depress card when hovered
            distance: _isHovered ? 2 : 6,
            blur: _isHovered ? 4 : 12,
            glowColor: _isHovered ? AppColors.primary : null,
          ),
          border: Border.all(
            color: _isHovered 
                ? theme.primaryColor.withValues(alpha: 0.3) 
                : Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon, 
              color: _isHovered ? theme.primaryColor : Colors.white70,
              size: 24,
            ),
            const SizedBox(width: 12),
            ResponsiveText(
              widget.name,
              style: TextStyle(
                color: _isHovered ? Colors.white : Colors.white70,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
