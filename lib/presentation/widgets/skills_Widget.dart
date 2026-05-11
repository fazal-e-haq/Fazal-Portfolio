import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This widget creates a colorful "tag" or "pill" to show a skill (like Flutter or Figma)
class SkillsWidget extends StatefulWidget {
  const SkillsWidget({
    super.key,
    required this.text, // The name of the skill
    required this.icon, // The icon for the skill
    required this.color, // The main color for the tag
    this.fontSize = 20, // Default font size
    this.iconSize = 30, // Default icon size
    this.horizontalPadding = 20, // Default horizontal padding
    this.verticalPadding = 8, // Default vertical padding
  });
  
  final String text;
  final IconData icon;
  final Color color;
  final double fontSize;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding, 
            horizontal: widget.horizontalPadding
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), // Makes it pill-shaped
            color: widget.color.withValues(alpha: 0.15), // Background is a faint version of the skill color
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2), 
                color: Colors.black26, 
                blurRadius: _isHovered ? 8 : 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: widget.iconSize), // The skill icon
              SizedBox(width: widget.iconSize * 0.25),
              Text(
                widget.text,
                style: GoogleFonts.unbounded(
                  color: widget.color,
                  fontWeight: FontWeight.w400,
                  fontSize: widget.fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
