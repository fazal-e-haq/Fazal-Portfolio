import 'package:flutter/material.dart';

// This widget creates a text input field (like for Name or Email) with a "sunken" design
class NeumorphicTextField extends StatelessWidget {
  final String hintText; // The text that shows inside when the field is empty
  final int maxLines; // How many lines of text the user can type
  final TextEditingController? controller; // To control and read text

  const NeumorphicTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF121212,
        ), // Darker color to make it look like it's cut into the card
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF2A2A2A), // Subtle border to help see the edges
          width: 1,
        ),
        boxShadow: const [
          // This shadow is placed inside/near the edges to give a sunken-in feeling
          BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(2, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,

        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color:
                Theme.of(context).inputDecorationTheme.hintStyle?.color ??
                Colors.grey.shade600,
          ),
          // border: OutlineInputBorder(borderRadius: .circular(15)), // Remove the default Flutter border
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
