import 'package:flutter/material.dart';

class HoverEffectButton extends StatefulWidget {
  HoverEffectButton({
    super.key,
    required this.text,
    this.hoveredHight ,
     this.hight,
    this.hoveredWidth,
    this.width,
  });
  Text text;
  double? hoveredHight ;
  double? hoveredWidth;
  double? hight;
  double? width;
  @override
  State<HoverEffectButton> createState() => _HoverEffectButtonState();
}

class _HoverEffectButtonState extends State<HoverEffectButton> {
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
        margin: .symmetric(horizontal: 6),
        padding: .symmetric(vertical: 8,horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: .circular(50),
          color: Colors.grey.shade300,
 boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black)],
        ),
        curve: Curves.easeOutCubic,
        duration: Duration(milliseconds: 300),
        height: ishovered ? widget.hoveredHight : widget.hight,
        width: ishovered ? widget.hoveredWidth : widget.width,
        transform: ishovered ? .translationValues(0, -8, 0) : .identity(),

        child: widget.text,
      ),
    );
  }
}
