import 'package:flutter/material.dart';

class HoverEffect extends StatefulWidget {
  HoverEffect({
    super.key,
    required this.child,
    this.hoveredHight ,
     this.hight,
    this.hoveredWidth,
    this.width,
  });
  Widget child;
  double? hoveredHight ;
  double? hoveredWidth;
  double? hight;
  double? width;
  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool ishovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          ishovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          ishovered = false;
        });
      },
      child: AnimatedContainer(
        curve: Curves.easeOutCubic,
        duration: Duration(milliseconds: 300),
        height: ishovered ? widget.hoveredHight : widget.hight,
        width: ishovered ? widget.hoveredWidth : widget.width,
        transform: ishovered ? .translationValues(0, -8, 0) : .identity(),

        child: widget.child,
      ),
    );
  }
}
