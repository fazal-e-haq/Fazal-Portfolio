import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This widget creates a colorful "tag" or "pill" to show a skill (like Flutter or Figma)
class SkillsWidget extends StatelessWidget {
  const SkillsWidget({
    super.key,
    required this.text, // The name of the skill
    required this.icon, // The icon for the skill
    required this.color, // The main color for the tag
  });
  final String text;
  final IconData icon;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100), // Makes it pill-shaped
        color: color.withValues(alpha: 0.15), // Background is a faint version of the skill color
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2), 
            color: Colors.black26, 
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 30), // The skill icon
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.unbounded(
              color: color,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
