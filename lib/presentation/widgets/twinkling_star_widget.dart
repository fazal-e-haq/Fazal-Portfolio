import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/star_model.dart';

class TwinkleStar extends StatefulWidget {
  final Star star;

  const TwinkleStar({super.key, required this.star});

  @override
  State<TwinkleStar> createState() => TwinkleStarState();
}

class TwinkleStarState extends State<TwinkleStar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final star = widget.star;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final time = _controller.value * 2 * pi;

        final twinkle = (sin(time * star.speed + star.phase) + 1) / 2;

        return Container(
          width: star.size,
          height: star.size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(star.baseOpacity * twinkle),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
