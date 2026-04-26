import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({
    super.key,
    required this.text,
    required this.icon,
    this.textColor = Colors.black,
  });
  final String text;
  final Icon icon;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .symmetric(vertical: 13, horizontal: 5),
      padding: .symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: .circular(100),
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(3, 3), color: Colors.black, blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.unbounded(
              color: textColor,
              fontWeight: .w400,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
