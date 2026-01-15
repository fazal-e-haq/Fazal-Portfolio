import 'package:flutter/material.dart';

class Neumorphism extends StatefulWidget {
  Neumorphism({super.key, this.child,this.borderRadius = 30});
  Widget? child;
  double borderRadius;
  @override
  State<Neumorphism> createState() => _NeumorphismState();
}

class _NeumorphismState extends State<Neumorphism> {
  @override
  Widget build(BuildContext context) {
    // return AnimatedContainer(
    //   height: 200,
    //   width: 200,
    //   duration: Duration(microseconds: 300),
    //   decoration: BoxDecoration(
    //     borderRadius: .circular(20),
    //     color: Colors.grey.shade900,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black12,
    //         offset: Offset(4, 4),
    //         blurRadius: 8,
    //         spreadRadius: 1,
    //       ),
    //       BoxShadow(
    //         color: Colors.black26,
    //         offset: Offset(-4, -4),
    //         blurRadius: 8,
    //         spreadRadius: 1,
    //       ),
    //     ],
    //   ),
    //   child: widget.child,
    // );
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      decoration: BoxDecoration(
        borderRadius: .circular(widget.borderRadius),
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
