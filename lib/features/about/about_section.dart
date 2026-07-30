import 'dart:math' as math;
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
        final double maxWidth = isMobile ? constraints.maxWidth : (isTablet ? 750 : 1000);

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 40,
                  vertical: isMobile ? 60 : 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSectionHeader(context, isMobile),
                    const SizedBox(height: 40),
                    
                    // Short Hero Sentence
                    ResponsiveText(
                      'I am a Flutter and UI/UX Designer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: isMobile ? 24 : 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 60),
                    
                    // Paragraphs
                    if (isMobile)
                      Column(
                        children: [
                          _buildFlutterParagraph(context),
                          const SizedBox(height: 24),
                          _buildDesignParagraph(context),
                        ],
                      )
                    else
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _buildFlutterParagraph(context)),
                            const SizedBox(width: 32),
                            Expanded(child: _buildDesignParagraph(context)),
                          ],
                        ),
                      ),
                    
                    const SizedBox(height: 100),
                    
                    // Skills Arsenal
                    _buildSkillsHeader(context, isMobile),
                    const SizedBox(height: 60),
                    const _FloatingSkillsGrid(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        ResponsiveText(
          'Discover',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontFamily: 'Unbounded',
          ),
        ),
        const SizedBox(height: 8),
        ResponsiveText(
          'About Me',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
          ),
        ),
      ],
    );
  }

  Widget _buildFlutterParagraph(BuildContext context) {
    return const _InfoCard(
      icon: CupertinoIcons.device_phone_portrait,
      title: 'Flutter Engineering',
      content: 'I specialize in building high-performance, responsive, and seamless cross-platform applications. Utilizing Dart and advanced state management architectures, I construct robust solutions that deliver native-level experiences.',
      accentColor: Colors.blueAccent,
    );
  }

  Widget _buildDesignParagraph(BuildContext context) {
    return const _InfoCard(
      icon: CupertinoIcons.paintbrush,
      title: 'UI/UX Design',
      content: 'I believe that great software is defined by its interface. From crafting pixel-perfect Figma prototypes to implementing stunning Neomorphic layouts, I ensure every interaction is visually striking and deeply intuitive.',
      accentColor: AppColors.primary,
    );
  }

  Widget _buildSkillsHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        ResponsiveText(
          'My Arsenal',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontFamily: 'Unbounded',
          ),
        ),
        const SizedBox(height: 8),
        ResponsiveText(
          'Skills & Tools',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 28 : 40,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.accentColor,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.neumorphicShadows(distance: 8, blur: 16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.03),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 32),
          ),
          const SizedBox(height: 24),
          ResponsiveText(
            title,
            style: const TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ResponsiveText(
            content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              height: 1.8,
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingSkillsGrid extends StatelessWidget {
  const _FloatingSkillsGrid();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Flutter', 'icon': CupertinoIcons.device_phone_portrait, 'color': Colors.blueAccent},
      {'name': 'Dart', 'icon': CupertinoIcons.chevron_left_slash_chevron_right, 'color': Colors.cyanAccent},
      {'name': 'UI/UX', 'icon': CupertinoIcons.paintbrush, 'color': Colors.purpleAccent},
      {'name': 'Firebase', 'icon': CupertinoIcons.cloud, 'color': Colors.orangeAccent},
      {'name': 'Figma', 'icon': CupertinoIcons.layers_alt, 'color': Colors.pinkAccent},
      {'name': 'Animation', 'icon': CupertinoIcons.rocket, 'color': Colors.greenAccent},
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: List.generate(skills.length, (index) {
        return _FloatingSkillCard(
          name: skills[index]['name'],
          icon: skills[index]['icon'],
          hoverColor: skills[index]['color'],
          delayOffset: index * 0.5, // Staggered floating effect
        );
      }),
    );
  }
}

class _FloatingSkillCard extends StatefulWidget {
  const _FloatingSkillCard({
    required this.name,
    required this.icon,
    required this.hoverColor,
    required this.delayOffset,
  });

  final String name;
  final IconData icon;
  final Color hoverColor;
  final double delayOffset;

  @override
  State<_FloatingSkillCard> createState() => _FloatingSkillCardState();
}

class _FloatingSkillCardState extends State<_FloatingSkillCard> with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // Continuous loop for math.sin
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          // Calculate floating vertical offset using sine wave
          // When hovered, we kill the floating effect to make it lock in place
          final double floatY = _isHovered 
              ? 0 
              : math.sin((_floatController.value * 2 * math.pi) + widget.delayOffset) * 8;

          return Transform.translate(
            offset: Offset(0, floatY),
            child: child,
          );
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          scale: _isHovered ? 1.08 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.surfaceInner : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? widget.hoverColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: _isHovered 
                  ? [
                      BoxShadow(
                        color: widget.hoverColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : AppColors.neumorphicShadows(distance: 6, blur: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? widget.hoverColor : Colors.white60,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: _isHovered ? FontWeight.bold : FontWeight.w600,
                    color: _isHovered ? widget.hoverColor : Colors.white70,
                    letterSpacing: 1.0,
                  ),
                  child: Text(widget.name),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
