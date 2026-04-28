import 'package:flutter/material.dart';

// This widget creates a dark "Neumorphic" card (a card with soft shadows)
class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.child, // The content to put inside the card
    this.width,
    this.height,
  });

  final double? height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            offset: const Offset(8, 8),
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
          ),
          BoxShadow(
            offset: const Offset(-8, -8),
            color: Colors.white.withValues(alpha: 0.03),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        // Padding adds space between the card's edge and its content. 
        // Using adaptive padding: smaller on small widths.
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width < 800 ? 25 : 60, 
          vertical: 30,
        ),
        child: child,
      ),
    );
  }
}
