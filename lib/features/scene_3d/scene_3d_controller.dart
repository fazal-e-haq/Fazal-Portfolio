import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/scene_point_3d.dart';
import '../app_shell/scroll_coordinator_controller.dart';

/// Controls 3D camera transforms, spatial world rotation, and coordinates
/// reacting to vertical scroll momentum and mouse parallax.
class Scene3DController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController tickerController;

  /// Camera position in world space
  final RxDouble cameraX = 0.0.obs;
  final RxDouble cameraY = 0.0.obs;
  final RxDouble cameraZ = 0.0.obs;

  /// Camera rotation (Euler angles in radians)
  final RxDouble cameraYaw = 0.0.obs;
  final RxDouble cameraPitch = 0.0.obs;
  final RxDouble cameraRoll = 0.0.obs;

  /// Focal length for perspective projection
  final double focalLength = 650.0;

  /// Starfield/constellation points in 3D world
  final List<ScenePoint3D> spatialPoints = [];

  ScrollCoordinatorController? _scrollCoordinator;

  @override
  void onInit() {
    super.onInit();
    tickerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _generateSpatialPoints(count: 180);

    // Link with scroll coordinator if registered
    if (Get.isRegistered<ScrollCoordinatorController>()) {
      _scrollCoordinator = Get.find<ScrollCoordinatorController>();
      _scrollCoordinator!.scrollProgress.listen(_onScrollProgressChanged);
      _scrollCoordinator!.mousePosition.listen(_onMouseMoved);
    }
  }

  void _generateSpatialPoints({required int count}) {
    spatialPoints.clear();
    for (int i = 0; i < count; i++) {
      final double x = (i * 73 % 1600) - 800.0;
      final double y = (i * 97 % 2400) - 1200.0;
      final double z = (i * 131 % 2000) + 150.0;
      final double radius = (i % 3 == 0) ? 2.5 : 1.2;
      final Color color = (i % 4 == 0)
          ? Colors.deepOrangeAccent.withValues(alpha: 0.6)
          : (i % 5 == 0 ? Colors.blueAccent.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.35));

      spatialPoints.add(ScenePoint3D(
        x: x,
        y: y,
        z: z,
        radius: radius,
        color: color,
      ));
    }
  }

  void _onScrollProgressChanged(double progress) {
    // Scroll progress 0.0 (Intro) -> 1.0 (About) -> 2.0 (Works) -> 3.0 (Contact)
    // Drives camera forward through Z-space with subtle orbital yaw & pitch
    cameraZ.value = progress * 400.0;
    cameraY.value = progress * 120.0;
    cameraPitch.value = (progress * 0.08);
  }

  void _onMouseMoved(Offset delta) {
    // Smoothly tilt camera based on cursor
    cameraYaw.value = delta.dx * 0.06;
    cameraRoll.value = -delta.dx * 0.02;
  }

  @override
  void onClose() {
    tickerController.dispose();
    super.onClose();
  }
}
