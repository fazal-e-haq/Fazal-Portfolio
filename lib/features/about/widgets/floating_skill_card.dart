import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../about_controller.dart';

class FloatingSkillCard extends StatefulWidget {
  const FloatingSkillCard({
    super.key,
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
  State<FloatingSkillCard> createState() => _FloatingSkillCardState();
}

class _FloatingSkillCardState extends State<FloatingSkillCard> with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AboutController _controller;
  late final String hoverKey;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AboutController>();
    hoverKey = 'skill_card_${widget.name}';
    
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
      onEnter: (_) => _controller.setHovered(hoverKey, true),
      onExit: (_) => _controller.setHovered(hoverKey, false),
      cursor: SystemMouseCursors.click,
      child: Obx(() {
        final bool isHovered = _controller.isHovered(hoverKey);
        
        return AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            final double progress = (_floatController.value * 2 * math.pi) + widget.delayOffset;
            
            final double floatY = isHovered ? 0 : math.sin(progress) * 10;
            final double floatX = isHovered ? 0 : math.cos(progress * 1.5) * 4;

            return Transform.translate(
              offset: Offset(floatX, floatY),
              child: child,
            );
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            scale: isHovered ? 1.15 : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: widget.isMobile 
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              decoration: BoxDecoration(
                color: isHovered ? AppColors.surfaceInner : AppColors.surface,
                borderRadius: BorderRadius.circular(50), 
                border: Border.all(
                  color: isHovered ? widget.hoverColor.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.05),
                  width: isHovered ? 1.5 : 1.0,
                ),
                boxShadow: isHovered 
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
                      color: isHovered ? widget.hoverColor : Colors.white60,
                      size: widget.isMobile ? 18 : 24,
                    ),
                  ),
                  SizedBox(width: widget.isMobile ? 8 : 12),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: widget.isMobile ? 11 : 16, 
                      fontWeight: isHovered ? FontWeight.bold : FontWeight.w600,
                      color: isHovered ? widget.hoverColor : Colors.white70,
                      letterSpacing: 1.0,
                    ),
                    child: Text(widget.name),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
