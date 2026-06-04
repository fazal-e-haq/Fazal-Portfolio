import 'dart:math';
import 'package:flutter/material.dart';

import '../../models/star_model.dart';

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarPainter({required this.stars, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // 🖤 solid background
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black);

    final paint = Paint()..style = PaintingStyle.fill;

    final time = animationValue * 2 * pi;

    for (final star in stars) {
      final dx = star.x * size.width;
      final dy = star.y * size.height;

      final twinkle = (sin(time * star.speed + star.phase) + 1) / 2;

      paint.color = Colors.white.withOpacity(star.baseOpacity * twinkle);

      canvas.drawCircle(Offset(dx, dy), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class StarFieldPainterWidget extends StatefulWidget {
  final double offset;

  const StarFieldPainterWidget({super.key, required this.offset});

  @override
  State<StarFieldPainterWidget> createState() => _StarFieldPainterWidgetState();
}

class _StarFieldPainterWidgetState extends State<StarFieldPainterWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Star> stars;

  final random = Random();

  @override
  void initState() {
    super.initState();

    stars = List.generate(
      300,
      (i) => Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 2.5 + 0.5,
        baseOpacity: random.nextDouble() * 0.7 + 0.3,
        phase: random.nextDouble() * 2 * pi,
        speed: random.nextDouble() * 0.5 + 0.2,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: StarPainter(stars: stars, animationValue: _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}
