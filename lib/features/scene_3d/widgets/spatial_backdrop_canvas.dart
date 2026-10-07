import 'package:flutter/material.dart';
import '../../../core/themes/theme.dart';

/// A subtle, raw pencil-sketch style grid background
class SpatialBackdropCanvas extends StatelessWidget {
  const SpatialBackdropCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: CustomPaint(
        size: Size.infinite,
        painter: _SketchGridPainter(),
      ),
    );
  }
}

class _SketchGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double gridSize = 100.0;
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      // Sketchy double line occasionally
      if (y % (gridSize * 3) == 0) {
        canvas.drawLine(Offset(0, y + 2), Offset(size.width, y + 2), paint);
      }
    }

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      // Sketchy double line occasionally
      if (x % (gridSize * 4) == 0) {
        canvas.drawLine(Offset(x + 2, 0), Offset(x + 2, size.height), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
