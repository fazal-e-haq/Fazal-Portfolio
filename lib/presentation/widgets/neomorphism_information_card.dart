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
    return Center(
      child: Container(
        height: height ?? 200,
        width: width ?? 200,
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xff1a1a1a),
          borderRadius: BorderRadius.circular(50),
          // boxShadow: [
          //   BoxShadow(
          //     spreadRadius: 1,
          //     blurRadius: 7,
          //     offset: Offset(4, 4),
          //     color: Colors.black.withValues(alpha: 0.6),
          //   ),
          //   BoxShadow(
          //     spreadRadius: 1,
          //     blurRadius: 7,
          //     offset: Offset(-4, -4),
          //     color: Colors.white.withValues(alpha: 0.03),
          //   ),
          // ],
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 30,
              offset: Offset(4, 4),
              color: Colors.white.withValues(alpha: 0.5),
            ),
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 15,
              offset: Offset(-4, -4),
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ),

        child: child,
      ),
    );
  }
}
