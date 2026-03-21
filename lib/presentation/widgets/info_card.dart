import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard({super.key, required this.widget});
  Widget widget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height * 0.69,
        width: size.width * 0.83,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff07C8F9), Color(0xff0D41E1)],
            begin: .topLeft,
            end: .bottomRight,
          ),
          borderRadius: .circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 70),
          child: widget,
        ),
      ),
    );
  }
}
