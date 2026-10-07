import 'package:flutter/material.dart';

/// Wraps any section or card in an interactive 3D perspective matrix transform.
/// Reacts to scroll position and cursor hover to create tangible depth and tilt.
class PerspectiveCardWrapper extends StatelessWidget {
  final Widget child;
  final double depthZ;
  final double tiltX;
  final double tiltY;
  final double perspective;

  const PerspectiveCardWrapper({
    super.key,
    required this.child,
    this.depthZ = 0.0,
    this.tiltX = 0.0,
    this.tiltY = 0.0,
    this.perspective = 0.001,
  });

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, perspective)
      ..setTranslationRaw(0.0, 0.0, depthZ)
      ..rotateX(tiltX)
      ..rotateY(tiltY);

    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
