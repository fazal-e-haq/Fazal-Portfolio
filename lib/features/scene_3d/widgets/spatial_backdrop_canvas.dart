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
    // Very faint, sketchy grey lines
    final paint1 = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.03)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
      
    final paint2 = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.02)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double gridSize = 80.0;
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint1);
      // Sketchy double line occasionally
      if (y % (gridSize * 3) == 0) {
        canvas.drawLine(Offset(0, y + 3), Offset(size.width, y + 1), paint2); // slightly crooked
      }
    }

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint1);
      // Sketchy double line occasionally
      if (x % (gridSize * 4) == 0) {
        canvas.drawLine(Offset(x + 2, 0), Offset(x - 1, size.height), paint2); // slightly crooked
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
