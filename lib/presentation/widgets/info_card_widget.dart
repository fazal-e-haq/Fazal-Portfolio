import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  // Constructor
  InfoCardWidget({
    super.key,
    required this.child,
    required this.width,
    required this.height,
  });
  //  Global variables
  double height;
  double width;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff07C8F9), Color(0xff0D41E1)],
          begin: .topLeft,
          end: .bottomRight,
        ),
        borderRadius: .circular(50),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 15,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: .symmetric(horizontal: 60, vertical: 30),
        child: child,
      ),
    );
  }
}
