import 'package:flutter/material.dart';

class NeomorphismInformationCard extends StatelessWidget {
  // Constructor
  const NeomorphismInformationCard({
    super.key,
    this.height,
    this.width,
    required this.child,
  });
  // Global variables
  final double? height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 700;
    return Center(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 26,
          vertical: isMobile ? 5 : 16,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 36,
          vertical: isMobile ? 10 : 16,
        ),
        decoration: BoxDecoration(
          color: Color(0xff1a1a1a),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(4, 4),
              color: Colors.black.withValues(alpha: 0.6),
            ),
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(-4, -4),
              color: Colors.white.withValues(alpha: 0.03),
            ),
          ],
        ),

        child: child,
      ),
    );
  }
}
