import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../scene_3d_controller.dart';

/// Renders a dynamic 3D depth-projected spatial canvas responding to camera motion
class SpatialBackdropCanvas extends StatelessWidget {
  const SpatialBackdropCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Scene3DController());

    return AnimatedBuilder(
      animation: controller.tickerController,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _SpatialCanvasPainter(controller: controller),
        );
      },
    );
  }
}

class _SpatialCanvasPainter extends CustomPainter {
  final Scene3DController controller;

  _SpatialCanvasPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()..isAntiAlias = true;
    final double focal = controller.focalLength;
    final double camZ = controller.cameraZ.value;
    final double yaw = controller.cameraYaw.value;
    final double pitch = controller.cameraPitch.value;

    for (final point in controller.spatialPoints) {
      final screenPos = point.project(
        screenSize: size,
        focalLength: focal,
        cameraZ: camZ,
        cameraYaw: yaw,
        cameraPitch: pitch,
      );

      // Skip off-screen or behind-camera points
      if (screenPos.dx < -50 ||
          screenPos.dx > size.width + 50 ||
          screenPos.dy < -50 ||
          screenPos.dy > size.height + 50) {
        continue;
      }

      final radius = point.projectedRadius(focal, camZ);
      paint.color = point.color;
      canvas.drawCircle(screenPos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SpatialCanvasPainter oldDelegate) => true;
}
