import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/themes/theme.dart';

/// Represents a 3D point in world space with perspective projection capabilities
class ScenePoint3D {
  final double x;
  final double y;
  final double z;
  final double radius;
  final Color color;

  const ScenePoint3D({
    required this.x,
    required this.y,
    required this.z,
    this.radius = 2.0,
    this.color = AppColors.textMain,
  });

  /// Projects 3D world coordinates onto 2D screen coordinates based on focal length
  Offset project({
    required Size screenSize,
    required double focalLength,
    required double cameraZ,
    double cameraYaw = 0.0,
    double cameraPitch = 0.0,
  }) {
    final double relZ = z - cameraZ;
    if (relZ <= 0.1) return const Offset(-9999, -9999);

    // Apply camera rotation (yaw around Y axis, pitch around X axis)
    final double cosYaw = math.cos(cameraYaw);
    final double sinYaw = math.sin(cameraYaw);
    final double rotX = (x * cosYaw) - (relZ * sinYaw);
    final double rotZ = (x * sinYaw) + (relZ * cosYaw);

    final double cosPitch = math.cos(cameraPitch);
    final double sinPitch = math.sin(cameraPitch);
    final double rotY = (y * cosPitch) - (rotZ * sinPitch);
    final double finalZ = (y * sinPitch) + (rotZ * cosPitch);

    if (finalZ <= 0.1) return const Offset(-9999, -9999);

    final double scale = focalLength / finalZ;
    final double screenX = (screenSize.width / 2) + (rotX * scale);
    final double screenY = (screenSize.height / 2) + (rotY * scale);

    return Offset(screenX, screenY);
  }

  /// Calculates scaled projected radius for depth representation
  double projectedRadius(double focalLength, double cameraZ) {
    final double relZ = z - cameraZ;
    if (relZ <= 0.1) return 0.0;
    return (radius * (focalLength / relZ)).clamp(0.5, radius * 3.0);
  }
}
