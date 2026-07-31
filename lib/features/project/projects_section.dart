import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/projects_details.dart';
import '../../core/themes/theme.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/responsive_text.dart';
import 'project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = Projects().projects;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final double maxWidth = (isMobile || isTablet) ? constraints.maxWidth * 0.95 : 1400;

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
                        'PROJECTS',
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
                        horizontal: isMobile ? 24 : 48,
                        vertical: isMobile ? 60 : 120,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Foreground Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResponsiveText(
                                'WORKS',
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: isMobile ? 40 : 80,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 4,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 120),
                          
                          // Projects List
                          Column(
                            children: List.generate(projects.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 120),
                                child: _PremiumProjectCard(
                                  project: projects[index],
                                  index: index,
                                  isMobile: isMobile || isTablet, // Tablet uses mobile layout
                                ),
                              );
                            }),
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
}

class _PremiumProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  final bool isMobile;

  const _PremiumProjectCard({
    required this.project,
    required this.index,
    required this.isMobile,
  });

  @override
  State<_PremiumProjectCard> createState() => _PremiumProjectCardState();
}

class _PremiumProjectCardState extends State<_PremiumProjectCard> {
  final ValueNotifier<Offset> _localMousePos = ValueNotifier<Offset>(Offset.zero);
  bool _isHovered = false;

  @override
  void dispose() {
    _localMousePos.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isImageLeft = widget.index % 2 == 0;

    final double cardRadius = widget.isMobile ? 24.0 : 32.0;
    final double innerRadius = widget.isMobile ? 16.0 : 20.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) {
        setState(() => _isHovered = false);
        _localMousePos.value = Offset.zero;
      },
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset center = Offset(box.size.width / 2, box.size.height / 2);
          _localMousePos.value = event.localPosition - center;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutExpo,
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceInner : AppColors.surface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.03),
            width: 1,
          ),
          boxShadow: _isHovered ? AppColors.neumorphicShadows(distance: 20, blur: 50, glowColor: AppColors.primary.withValues(alpha: 0.1)) : null,
        ),
        padding: EdgeInsets.all(widget.isMobile ? 16 : 40), // Responsive child padding
        child: widget.isMobile
            ? _buildMobileLayout(innerRadius)
            : _buildDesktopLayout(isImageLeft, innerRadius),
      ),
    );
  }

  Widget _buildDesktopLayout(bool isImageLeft, double radius) {
    final imageWidget = Expanded(
      flex: 6,
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: _buildInteractiveImage(radius),
      ),
    );

    final detailsWidget = Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.only(
          left: isImageLeft ? 60.0 : 0.0,
          right: isImageLeft ? 0.0 : 60.0,
        ),
        child: _buildDetails(isImageLeft: isImageLeft, radius: radius),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isImageLeft 
          ? [imageWidget, detailsWidget] 
          : [detailsWidget, imageWidget],
    );
  }

  Widget _buildMobileLayout(double radius) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: SizedBox(
            width: double.infinity,
            child: _buildInteractiveImage(radius),
          ),
        ),
        const SizedBox(height: 32),
        _buildDetails(isImageLeft: true, radius: radius), // Mobile defaults to left aligned text
      ],
    );
  }

  Widget _buildInteractiveImage(double radius) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _localMousePos,
      builder: (context, delta, child) {
        // Subtle 3D perspective rotation (Increased range for better effect)
        double dx = _isHovered ? (delta.dx / 800).clamp(-0.15, 0.15) : 0;
        double dy = _isHovered ? (delta.dy / 800).clamp(-0.15, 0.15) : 0;
        double rotateX = dy * -1;
        double rotateY = dx;

        final Matrix4 transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(rotateX)
          ..rotateY(rotateY);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutExpo,
          transform: transform,
          transformAlignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), // Less rounded image
            boxShadow: _isHovered 
                ? AppColors.neumorphicShadows(distance: 20, blur: 50, glowColor: AppColors.primary.withValues(alpha: 0.3))
                : AppColors.neumorphicShadows(distance: 10, blur: 30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedScale(
                  duration: const Duration(seconds: 15), // Even slower scale
                  scale: _isHovered ? 1.05 : 1.0,
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                // Dark tint when not hovered so it blends with background
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutExpo,
                  opacity: _isHovered ? 0.0 : 0.4,
                  child: Container(
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetails({required bool isImageLeft, required double radius}) {
    final CrossAxisAlignment alignment = widget.isMobile 
        ? CrossAxisAlignment.start 
        : (isImageLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end);
        
    final TextAlign textAlign = widget.isMobile 
        ? TextAlign.left 
        : (isImageLeft ? TextAlign.left : TextAlign.right);

    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Type Badge
        AnimatedContainer(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutExpo,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _isHovered ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface,
                AppColors.surfaceInner,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radius), // Less rounded badge
            border: Border.all(
              color: _isHovered ? AppColors.primary.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.05),
            ),
            boxShadow: _isHovered ? AppColors.neumorphicShadows(distance: 2, blur: 10, glowColor: AppColors.primary.withValues(alpha: 0.2)) : null,
          ),
          child: Text(
            widget.project.type.toUpperCase(),
            style: TextStyle(
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
              fontFamily: 'Unbounded',
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Title
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutExpo,
          style: TextStyle(
            fontSize: widget.isMobile ? 32 : 56,
            fontWeight: FontWeight.w900,
            fontFamily: 'Unbounded',
            color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.9),
            letterSpacing: _isHovered ? 2.0 : 0.0,
          ),
          textAlign: textAlign,
          child: Text(widget.project.title),
        ),
        const SizedBox(height: 32),
        
        // Description
        AnimatedContainer(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutExpo,
          padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 24 : 40, vertical: widget.isMobile ? 24 : 32),
          decoration: BoxDecoration(
            color: AppColors.surfaceInner,
            borderRadius: BorderRadius.circular(radius), // Less rounded description
            border: Border.all(
              color: _isHovered ? AppColors.primary.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.03),
            ),
            boxShadow: _isHovered ? AppColors.neumorphicShadows(isPressed: true, distance: 4) : null,
          ),
          child: Text(
            widget.project.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.8,
              fontFamily: 'Poppins',
            ),
            textAlign: textAlign,
          ),
        ),
        const SizedBox(height: 32),
        
        // Tags
        if (widget.project.tags.isNotEmpty)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: widget.isMobile 
                ? WrapAlignment.start 
                : (isImageLeft ? WrapAlignment.start : WrapAlignment.end),
            children: widget.project.tags.map((tag) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutExpo,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: _isHovered ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
                  borderRadius: BorderRadius.circular(radius), // Less rounded tag
                  border: Border.all(
                    color: _isHovered ? AppColors.primary.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
                  ),
                  boxShadow: _isHovered ? AppColors.neumorphicShadows(distance: 4, blur: 8, glowColor: AppColors.primary.withValues(alpha: 0.1)) : null,
                ),
                child: Text(
                  tag, // Removed '#' prefix
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _isHovered ? AppColors.primary : AppColors.textSecondary,
                    letterSpacing: 1.5,
                  ),
                ),
              );
            }).toList(),
          ),
        
        const SizedBox(height: 48),
        
        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: widget.isMobile 
              ? WrapAlignment.start 
              : (isImageLeft ? WrapAlignment.start : WrapAlignment.end),
          children: [
            if (widget.project.liveUrl != null)
              ButtonWidget(
                id: 'btn_${widget.project.id}_live',
                onPressed: () => _launchUrl(widget.project.liveUrl!),
                icon: const Icon(CupertinoIcons.eye),
                text: const Text('Live Preview'),
              ),
            if (widget.project.codeUrl != null)
              ButtonWidget(
                id: 'btn_${widget.project.id}_code',
                onPressed: () => _launchUrl(widget.project.codeUrl!),
                icon: const Icon(CupertinoIcons.chevron_left_slash_chevron_right),
                text: const Text('Source Code'),
                color: AppColors.surfaceInner,
              ),
          ],
        ),
      ],
    );
  }
}
