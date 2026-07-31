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
        final double maxWidth = isMobile ? constraints.maxWidth : (isTablet ? constraints.maxWidth * 0.95 : 1400);

        return Stack(
          children: [
            // Fixed Background Watermark
            Positioned.fill(
              child: Center(
                child: IgnorePointer(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'ABOUT',
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
            
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ResponsiveText(
                              'Experience',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: isMobile ? 32 : 48,
                                color: AppColors.primary, // Using primary color
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Short Hero Sentence
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ResponsiveText(
                              'I am a Flutter Developer and Product Designer.',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Unbounded',
                                fontSize: isMobile ? 22 : 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          
                          // Paragraphs
                          if (isMobile)
                            Column(
                              children: [
                                _buildFlutterParagraph(context, isMobile, isTablet),
                                const SizedBox(height: 24),
                                _buildDesignParagraph(context, isMobile, isTablet),
                              ],
                            )
                          else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 400), 
                                    child: _buildFlutterParagraph(context, isMobile, isTablet),
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 400), 
                                    child: _buildDesignParagraph(context, isMobile, isTablet),
                                  ),
                                ),
                              ],
                            ),
                          
                          const SizedBox(height: 100),
                          
                          // Skills Arsenal
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ResponsiveText(
                              'Skills',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: isMobile ? 28 : 48,
                                color: AppColors.primary, // Using primary color
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          _FloatingSkillsGrid(isMobile: isMobile),
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

  Widget _buildFlutterParagraph(BuildContext context, bool isMobile, bool isTablet) {
    return _HoverInfoCard(
      icon: CupertinoIcons.device_phone_portrait,
      title: 'Flutter Engineering',
      content: 'I specialize in building high-performance, responsive, and seamless cross-platform applications. Drawing from my foundational experience as a Flutter Intern at NeuroApp, I utilize Dart and advanced state management to construct robust, production-ready solutions.',
      accentColor: Colors.blueAccent,
      isMobile: isMobile,
      isTablet: isTablet,
    );
  }

  Widget _buildDesignParagraph(BuildContext context, bool isMobile, bool isTablet) {
    return _HoverInfoCard(
      icon: CupertinoIcons.paintbrush,
      title: 'UI/UX Design',
      content: 'I believe that great software is defined by its interface. From crafting pixel-perfect Figma prototypes to implementing stunning Neomorphic layouts, I ensure every interaction is visually striking and deeply intuitive.',
      accentColor: AppColors.primary,
      isMobile: isMobile,
      isTablet: isTablet,
    );
  }
}

class _HoverInfoCard extends StatefulWidget {
  const _HoverInfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.accentColor,
    required this.isMobile,
    required this.isTablet,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;
  final bool isMobile;
  final bool isTablet;

  @override
  State<_HoverInfoCard> createState() => _HoverInfoCardState();
}

class _HoverInfoCardState extends State<_HoverInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        offset: _isHovered ? const Offset(0, -0.05) : Offset.zero,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          scale: _isHovered ? 1.05 : 1.0, // More aggressive scale
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: _isHovered 
                  ? AppColors.neumorphicShadows(distance: 20, blur: 40, glowColor: widget.accentColor.withValues(alpha: 0.25)) // Massively enhanced glow
                  : AppColors.neumorphicShadows(distance: 8, blur: 16),
              border: Border.all(
                color: _isHovered 
                    ? widget.accentColor.withValues(alpha: 0.5) 
                    : Colors.white.withValues(alpha: 0.03),
                width: _isHovered ? 2.0 : 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isHovered 
                        ? widget.accentColor.withValues(alpha: 0.3) 
                        : widget.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: _isHovered 
                        ? [
                            BoxShadow(
                              color: widget.accentColor.withValues(alpha: 0.6),
                              blurRadius: 20,
                              spreadRadius: 4,
                            )
                          ]
                        : [],
                  ),
                  child: Icon(widget.icon, color: widget.accentColor, size: 32),
                ),
              const SizedBox(height: 24),
              ResponsiveText(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: widget.isMobile ? 22 : (widget.isTablet ? 18 : 22), // Scaled for tablet
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ResponsiveText(
                widget.content,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  height: 1.8,
                  fontSize: widget.isMobile ? 14 : (widget.isTablet ? 13 : 15), // Scaled down for tablet/mobile
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _FloatingSkillsGrid extends StatelessWidget {
  const _FloatingSkillsGrid({required this.isMobile});
  
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> skills = [
      {'name': 'Flutter', 'icon': Icons.phone_iphone, 'color': Colors.blueAccent},
      {'name': 'Dart', 'icon': Icons.code, 'color': Colors.cyanAccent},
      {'name': 'Provider', 'icon': Icons.account_tree, 'color': Colors.lightBlue},
      {'name': 'GetX', 'icon': Icons.bolt, 'color': Colors.deepPurpleAccent},
      {'name': 'Firebase', 'icon': Icons.cloud, 'color': Colors.orangeAccent},
      {'name': 'Isar', 'icon': Icons.storage, 'color': Colors.pinkAccent},
      {'name': 'Supabase', 'icon': Icons.data_usage, 'color': Colors.greenAccent},
      {'name': 'Figma', 'icon': Icons.draw, 'color': Colors.pink},
      {'name': 'Git/GitHub', 'icon': Icons.merge_type, 'color': Colors.white},
      {'name': 'Antigravity', 'icon': Icons.rocket_launch, 'color': Colors.deepOrangeAccent},
      {'name': 'Android Studio', 'icon': Icons.laptop, 'color': Colors.green},
      {'name': 'REST API / Postman', 'icon': Icons.http, 'color': Colors.orange},
    ];

    return Wrap(
      spacing: isMobile ? 16 : 40,
      runSpacing: isMobile ? 16 : 40,
      alignment: WrapAlignment.center,
      children: List.generate(skills.length, (index) {
        return _FloatingSkillCard(
          name: skills[index]['name'],
          icon: skills[index]['icon'],
          hoverColor: skills[index]['color'],
          delayOffset: index * 0.7, 
          isMobile: isMobile,
          index: index,
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
    required this.isMobile,
    required this.index,
  });

  final String name;
  final IconData icon;
  final Color hoverColor;
  final double delayOffset;
  final bool isMobile;
  final int index;

  @override
  State<_FloatingSkillCard> createState() => _FloatingSkillCardState();
}

class _FloatingSkillCardState extends State<_FloatingSkillCard> with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    final int randomDuration = 3500 + (widget.index % 4) * 500; 
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: randomDuration),
    )..repeat(); 
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
          final double progress = (_floatController.value * 2 * math.pi) + widget.delayOffset;
          
          final double floatY = _isHovered ? 0 : math.sin(progress) * 10;
          final double floatX = _isHovered ? 0 : math.cos(progress * 1.5) * 4;

          return Transform.translate(
            offset: Offset(floatX, floatY),
            child: child,
          );
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          scale: _isHovered ? 1.15 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: widget.isMobile 
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                : const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.surfaceInner : AppColors.surface,
              borderRadius: BorderRadius.circular(50), 
              border: Border.all(
                color: _isHovered ? widget.hoverColor.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.05),
                width: _isHovered ? 1.5 : 1.0,
              ),
              boxShadow: _isHovered 
                  ? [
                      BoxShadow(
                        color: widget.hoverColor.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                      BoxShadow(
                        color: widget.hoverColor.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 8,
                      ),
                    ]
                  : AppColors.neumorphicShadows(distance: 4, blur: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? widget.hoverColor : Colors.white60,
                    size: widget.isMobile ? 18 : 24,
                  ),
                ),
                SizedBox(width: widget.isMobile ? 8 : 12),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: widget.isMobile ? 11 : 16, 
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
