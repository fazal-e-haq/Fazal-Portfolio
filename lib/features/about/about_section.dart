import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/animations/fade_in_up_widget.dart';
import '../../../widgets/sketch_painter.dart';
import 'about_controller.dart';

/// Expressive, ultra-polished About Section designed in Hand-Drawn Brutalism.
///
/// Features:
/// 1. Centered Header & Structure: Balanced layout following the sketchbook paper aesthetic.
/// 2. What I Solve: Medium-length problem-solving chips styled as hand-drawn ribbon tags
///    hanging from sketched wires and scattered with organic random rotations.
/// 3. Advanced Neural Network UI: Expanded 15-node architectural graph (Dart ➔ Flutter ➔ Cloud ➔ Delivery)
///    with increased size, curved synaptic Bezier lines, traveling graphite pulses, and 3D spring hover physics.
/// 4. Winding Hand-Drawn Roadmap (NO straight lines, NO points, NO icons, NO hover effects):
///    An authentic winding dashed pencil road weaving smoothly between milestones without any overflow.
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<AboutController>()) {
      Get.put(AboutController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 980;
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : (isTablet ? 32.0 : 64.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Centered Section Header
                  SketchSectionHeader(
                    tag: '01 // ABOUT ME',
                    title: 'The Story & Craft',
                    subtitle:
                        'What I solve, how I engineer, and the architecture behind my work.',
                    isMobile: isMobile,
                    seed: 11,
                  ),
                  SizedBox(height: isMobile ? 36 : 52),

                  // 2. What I Solve: Dropped Ribbon Chips Scattered Across the Page
                  FadeInUpWidget(
                    delay: const Duration(milliseconds: 160),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1040),
                        child: _WhatISolveRibbonSection(isMobile: isCompact),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 54 : 76),

                  // 3. Advanced Tech Stack Neural Network (Increased Size, Centered)
                  FadeInUpWidget(
                    delay: const Duration(milliseconds: 280),
                    child: _NeuralNetworkSection(isMobile: isCompact),
                  ),
                  SizedBox(height: isMobile ? 54 : 76),

                  // 4. Winding Hand-Drawn Roadmap (Not Straight, NO points, NO icons, NO hover effects)
                  FadeInUpWidget(
                    delay: const Duration(milliseconds: 380),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 920),
                        child: _WindingRoadmapSection(isMobile: isCompact),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 1. WHAT I SOLVE: SUSPENDED RIBBON CHIPS ON WIRE (NO HOVER EFFECTS)
// ═══════════════════════════════════════════════════════════════════════════

class _WhatISolveRibbonSection extends StatelessWidget {
  final bool isMobile;

  const _WhatISolveRibbonSection({required this.isMobile});

  // Client-approved technical solutions
  static const List<String> _solutions = [
    'Building cross-platform mobile and web apps',
    'Designing sleek, intuitive, user-friendly interfaces',
    'Scalable state management for complex apps',
    'Automated CI/CD pipelines for faster releases',
    'Optimizing apps for fast, lag-free performance',
    'Reliable offline-first apps with local storage',
    'Seamless cloud backend and API integration',
    'Responsive layouts that fit every screen',
    'Writing clean, maintainable, and scalable code',
    'Turning raw ideas into launch-ready products',
  ];

  // Natural organic slight tilt angles (pseudo-random scatter)
  static const List<double> _rotations = [
    -0.030,
    0.025,
    -0.020,
    0.035,
    -0.025,
    0.020,
    -0.035,
    0.030,
    -0.018,
    0.025,
  ];

  // Hanging wire lengths for varied organic vertical staggering
  static const List<double> _wireLengths = [
    20.0,
    14.0,
    24.0,
    16.0,
    22.0,
    12.0,
    26.0,
    15.0,
    18.0,
    22.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pure text header
        const Text(
          'WHAT I SOLVE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 20),

        // Overhead Suspension Wire Line
        const CustomPaint(
          size: Size(double.infinity, 16),
          painter: _OverheadWirePainter(),
        ),
        const SizedBox(height: 4),

        // Randomly Scattered Hanging Ribbon Chips (NO HOVER EFFECT, FULLY RESPONSIVE)
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: isMobile ? 12 : 18,
          runSpacing: isMobile ? 14 : 20,
          children: List.generate(_solutions.length, (index) {
            final double rotation = _rotations[index % _rotations.length];
            final double wireLength = isMobile
                ? _wireLengths[index % _wireLengths.length] * 0.65
                : _wireLengths[index % _wireLengths.length];

            return Transform.rotate(
              angle: rotation,
              child: _RibbonWireChip(
                text: _solutions[index],
                wireLength: wireLength,
                seed: index * 17 + 7,
                isMobile: isMobile,
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Overhead wavy suspension line drawn across the top.
class _OverheadWirePainter extends CustomPainter {
  const _OverheadWirePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    if (w <= 0) return;

    final Paint wirePaint = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.35)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path()
      ..moveTo(12, 8)
      ..quadraticBezierTo(w * 0.25, 14, w * 0.5, 9)
      ..quadraticBezierTo(w * 0.75, 4, w - 12, 8);

    canvas.drawPath(path, wirePaint);

    // Left & right anchor wall hooks
    final Paint hookPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(12, 8), 3.5, hookPaint);
    canvas.drawCircle(Offset(w - 12, 8), 3.5, hookPaint);
  }

  @override
  bool shouldRepaint(covariant _OverheadWirePainter oldDelegate) => false;
}

/// Individual ribbon chip with a hanging wire loop (STATIC, NO HOVER EFFECT).
class _RibbonWireChip extends StatelessWidget {
  final String text;
  final double wireLength;
  final int seed;
  final bool isMobile;

  const _RibbonWireChip({
    required this.text,
    required this.wireLength,
    required this.seed,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Sketched hanging wire from suspension cable
        CustomPaint(
          size: Size(16, wireLength),
          painter: _HangingWirePainter(length: wireLength, seed: seed),
        ),

        // Ribbon banner chip with notched fishtail ends
        CustomPaint(
          painter: _SketchRibbonTagPainter(seed: seed),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? 310.0 : 440.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 24,
              vertical: isMobile ? 8 : 10,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textMain,
                letterSpacing: 0.4,
                height: 1.25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Hand-drawn hanging wire with small top loop.
class _HangingWirePainter extends CustomPainter {
  final double length;
  final int seed;

  const _HangingWirePainter({required this.length, required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final double midX = size.width * 0.5;

    final Paint wirePaint = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.65)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path wirePath = Path()
      ..moveTo(midX, 0)
      ..quadraticBezierTo(
        midX + math.sin(seed * 2.3) * 2.0,
        length * 0.5,
        midX,
        length,
      );

    canvas.drawPath(wirePath, wirePaint);

    // Top loop hooking onto cable
    final Paint loopPaint = Paint()
      ..color = AppColors.textMain
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(midX, 2), 2.2, loopPaint);
  }

  @override
  bool shouldRepaint(covariant _HangingWirePainter oldDelegate) =>
      oldDelegate.length != length || oldDelegate.seed != seed;
}

/// Hand-drawn ribbon tag painter with notched swallowtail ends (NO HOVER EFFECT).
class _SketchRibbonTagPainter extends CustomPainter {
  final int seed;

  const _SketchRibbonTagPainter({required this.seed});

  double _noise(int step) {
    return math.sin(step * 2.39996 + seed * 1.61803) * 0.65 +
        math.cos(step * 4.12345 - seed * 0.87654) * 0.35;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) return;

    const double notch = 8.0;
    final Path ribbonPath = Path();

    // Top edge
    ribbonPath.moveTo(notch, 0);
    ribbonPath.quadraticBezierTo(w * 0.5, _noise(1) * 1.4, w - notch, 0);

    // Right fishtail notch
    ribbonPath.lineTo(w, h * 0.5);
    ribbonPath.lineTo(w - notch, h);

    // Bottom edge
    ribbonPath.quadraticBezierTo(w * 0.5, h + _noise(2) * 1.4, notch, h);

    // Left fishtail notch
    ribbonPath.lineTo(0, h * 0.5);
    ribbonPath.close();

    // Fill with warm sketchbook paper
    final Paint fillPaint = Paint()
      ..color = AppColors.background.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;
    canvas.drawPath(ribbonPath, fillPaint);

    // Pass 1: Main charcoal border
    final Paint strokePaint1 = Paint()
      ..color = AppColors.textMain
      ..strokeWidth = 1.9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(ribbonPath, strokePaint1);

    // Pass 2: Overlapping graphite pencil scribble
    final Path overlap = Path();
    overlap.moveTo(notch + 1, 1);
    overlap.quadraticBezierTo(w * 0.5, _noise(3) * 1.8, w - notch - 1, 1);
    overlap.lineTo(w - 1, h * 0.5);
    overlap.lineTo(w - notch - 1, h - 1);
    overlap.quadraticBezierTo(
      w * 0.5,
      h - 1 + _noise(4) * 1.8,
      notch + 1,
      h - 1,
    );
    overlap.lineTo(1, h * 0.5);
    overlap.close();

    final Paint strokePaint2 = Paint()
      ..color = AppColors.textMain.withValues(alpha: 0.30)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(overlap, strokePaint2);

    // Top center wire eyelet
    final Paint eyeletPaint = Paint()
      ..color = AppColors.textMain
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(w * 0.5, 3), 2.0, eyeletPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchRibbonTagPainter oldDelegate) =>
      oldDelegate.seed != seed;
}

// ═══════════════════════════════════════════════════════════════════════════
// 2. ADVANCED TECH STACK NEURAL NETWORK (INCREASED SIZE, 15 NODES)
// ═══════════════════════════════════════════════════════════════════════════

class _NeuralNodeData {
  final String id;
  final String label;
  final String role;
  final IconData icon;
  final double x; // 0.0 - 1.0
  final double y; // 0.0 - 1.0
  final bool isCore;

  const _NeuralNodeData({
    required this.id,
    required this.label,
    required this.role,
    required this.icon,
    required this.x,
    required this.y,
    this.isCore = false,
  });
}

class _NeuralEdge {
  final String fromId;
  final String toId;

  const _NeuralEdge(this.fromId, this.toId);
}

class _NeuralNetworkSection extends StatefulWidget {
  final bool isMobile;

  const _NeuralNetworkSection({required this.isMobile});

  @override
  State<_NeuralNetworkSection> createState() => _NeuralNetworkSectionState();
}

class _NeuralNetworkSectionState extends State<_NeuralNetworkSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  String? _hoveredNodeId;

  // Organic Random Constellation / Neural Network (Scattered layout with user skills)
  static const List<_NeuralNodeData> _nodes = [
    _NeuralNodeData(
      id: 'figma',
      label: 'Figma',
      role: 'Interface Prototyping',
      icon: CupertinoIcons.paintbrush_fill,
      x: 0.10,
      y: 0.32,
    ),
    _NeuralNodeData(
      id: 'git',
      label: 'Git / GitHub',
      role: 'Version & CI/CD',
      icon: CupertinoIcons.arrow_branch,
      x: 0.14,
      y: 0.68,
    ),
    _NeuralNodeData(
      id: 'dart',
      label: 'Dart',
      role: 'Language Foundation',
      icon: CupertinoIcons.chevron_left_slash_chevron_right,
      x: 0.28,
      y: 0.22,
      isCore: true,
    ),
    _NeuralNodeData(
      id: 'flutter',
      label: 'Flutter',
      role: 'Cross-Platform Core',
      icon: CupertinoIcons.device_phone_portrait,
      x: 0.44,
      y: 0.42,
      isCore: true,
    ),
    _NeuralNodeData(
      id: 'state',
      label: 'GetX / Provider / Riverpod',
      role: 'Reactive State Architecture',
      icon: CupertinoIcons.bolt_fill,
      x: 0.38,
      y: 0.80,
      isCore: true,
    ),
    _NeuralNodeData(
      id: 'isar',
      label: 'Isar',
      role: 'Local Database Cache',
      icon: CupertinoIcons.archivebox_fill,
      x: 0.20,
      y: 0.88,
    ),
    _NeuralNodeData(
      id: 'stack',
      label: 'Stack',
      role: 'Clean Architecture',
      icon: CupertinoIcons.square_stack_3d_up_fill,
      x: 0.58,
      y: 0.18,
    ),
    _NeuralNodeData(
      id: 'rest',
      label: 'REST API',
      role: 'High-Speed Networking',
      icon: CupertinoIcons.arrow_right_arrow_left,
      x: 0.68,
      y: 0.48,
    ),
    _NeuralNodeData(
      id: 'firebase',
      label: 'Firebase',
      role: 'Cloud Backend & Auth',
      icon: CupertinoIcons.cloud_fill,
      x: 0.74,
      y: 0.80,
    ),
    _NeuralNodeData(
      id: 'postman',
      label: 'Postman',
      role: 'API Testing & Debug',
      icon: CupertinoIcons.paperplane_fill,
      x: 0.88,
      y: 0.34,
    ),
  ];

  static const List<_NeuralEdge> _edges = [
    // Design & Version Control
    _NeuralEdge('figma', 'flutter'),
    _NeuralEdge('git', 'dart'),
    _NeuralEdge('git', 'flutter'),

    // Core Foundation
    _NeuralEdge('dart', 'flutter'),
    _NeuralEdge('flutter', 'state'),
    _NeuralEdge('flutter', 'stack'),
    _NeuralEdge('flutter', 'rest'),
    _NeuralEdge('flutter', 'firebase'),

    // State & Local Storage
    _NeuralEdge('state', 'isar'),
    _NeuralEdge('isar', 'flutter'),

    // Networking, Backend & Architecture
    _NeuralEdge('stack', 'rest'),
    _NeuralEdge('stack', 'postman'),
    _NeuralEdge('rest', 'postman'),
    _NeuralEdge('rest', 'firebase'),
    _NeuralEdge('state', 'firebase'),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000), // Calm, soothing, slow tempo
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pure text header
        const Text(
          'TECH STACK',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 24),

        // Neural Network Graph on all devices (Desktop, Tablet, Mobile identical experience)
        _buildNeuralGraph(),
      ],
    );
  }

  Widget _buildNeuralGraph() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenW = constraints.maxWidth;
        final bool isCompact = screenW < 768;
        final double graphHeight = isCompact ? 530.0 : 510.0;
        final double effectiveW = math.max(screenW, 340.0);

        return SizedBox(
          height: graphHeight,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final double animVal = _pulseController.value;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Synaptic Curved Bezier Edges with Continuous Signal Pulses & Comet Tails
                  CustomPaint(
                    size: Size(effectiveW, graphHeight),
                    painter: _AdvancedSynapticPainter(
                      nodes: _nodes,
                      edges: _edges,
                      hoveredNodeId: _hoveredNodeId,
                      pulseProgress: animVal,
                      isMobile: isCompact,
                    ),
                  ),

                  // Interactive Nodes with gentle floating breathing motion & spring hover
                  ..._nodes.map((node) {
                    final double safeX =
                        isCompact ? (0.13 + node.x * 0.74) : node.x;
                    final double nodeX = safeX * effectiveW;
                    final double nodeY = node.y * graphHeight;
                    final bool isHovered = _hoveredNodeId == node.id;
                    final bool isRelated =
                        _hoveredNodeId != null &&
                        _edges.any(
                          (e) =>
                              (e.fromId == _hoveredNodeId && e.toId == node.id) ||
                              (e.toId == _hoveredNodeId && e.fromId == node.id),
                        );

                    // Organic subtle floating breathing offset - very calm and slow
                    final double floatY = isHovered
                        ? 0.0
                        : math.sin((animVal * 2.0 * math.pi) + (node.id.hashCode.abs() % 10)) * (isCompact ? 1.8 : 2.5);
                    final double floatX = isHovered
                        ? 0.0
                        : math.cos((animVal * 2.0 * math.pi) + (node.id.hashCode.abs() % 7)) * (isCompact ? 1.2 : 1.5);

                    return Positioned(
                      left: nodeX + floatX,
                      top: nodeY + floatY,
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, -0.5),
                        child: _CoolNeuralNode(
                          node: node,
                          isHovered: isHovered,
                          isRelated: isRelated,
                          isMobile: isCompact,
                          onHover: (hovering) {
                            setState(() {
                              _hoveredNodeId = hovering ? node.id : null;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

/// Custom painter for curved synaptic lines with animated graphite pulses and comet tails.
class _AdvancedSynapticPainter extends CustomPainter {
  final List<_NeuralNodeData> nodes;
  final List<_NeuralEdge> edges;
  final String? hoveredNodeId;
  final double pulseProgress;
  final bool isMobile;

  _AdvancedSynapticPainter({
    required this.nodes,
    required this.edges,
    required this.hoveredNodeId,
    required this.pulseProgress,
    this.isMobile = false,
  });

  _NeuralNodeData? _findNode(String id) {
    try {
      return nodes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  double _nodeX(double x, double w) {
    if (!isMobile) return x * w;
    return (0.13 + x * 0.74) * w;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    if (w <= 0 || h <= 0) return;

    for (int i = 0; i < edges.length; i++) {
      final edge = edges[i];
      final from = _findNode(edge.fromId);
      final to = _findNode(edge.toId);
      if (from == null || to == null) continue;

      final Offset p1 = Offset(_nodeX(from.x, w), from.y * h);
      final Offset p2 = Offset(_nodeX(to.x, w), to.y * h);

      final bool isConnectedToHovered =
          hoveredNodeId != null &&
          (edge.fromId == hoveredNodeId || edge.toId == hoveredNodeId);

      // Curved Bezier curve
      final double midX = (p1.dx + p2.dx) * 0.5;
      final double midY =
          (p1.dy + p2.dy) * 0.5 + math.sin(i * 1.5 + 0.4) * 18.0;

      final Path path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..quadraticBezierTo(midX, midY, p2.dx, p2.dy);

      // Synaptic wire rendering
      if (isConnectedToHovered) {
        // Soft primary glow aura
        final Paint auraPaint = Paint()
          ..color = AppColors.primary.withValues(alpha: 0.22)
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(path, auraPaint);

        // Active primary stroke
        final Paint activePaint = Paint()
          ..color = AppColors.primary.withValues(alpha: 0.95)
          ..strokeWidth = 2.4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(path, activePaint);

        // Secondary sketch stroke with subtle organic hand-drawn wobble
        final double wobbleY =
            math.sin(i * 2.1 + pulseProgress * 2 * math.pi) * 1.6;
        final Path companionPath = Path()
          ..moveTo(p1.dx, p1.dy + wobbleY * 0.5)
          ..quadraticBezierTo(midX, midY + wobbleY, p2.dx, p2.dy + wobbleY * 0.5);
        final Paint companionPaint = Paint()
          ..color = AppColors.primary.withValues(alpha: 0.40)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(companionPath, companionPaint);
      } else if (hoveredNodeId != null) {
        // Dimmed inactive wire when another node is hovered
        final Paint dimPaint = Paint()
          ..color = AppColors.textMain.withValues(alpha: 0.08)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(path, dimPaint);
      } else {
        // Standard hand-drawn graphite wire
        final Paint linePaint = Paint()
          ..color = AppColors.textMain.withValues(alpha: 0.22)
          ..strokeWidth = 1.4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(path, linePaint);
      }

      // Synaptic Terminal Junction Anchors (p1 and p2)
      final Paint terminalPaint = Paint()
        ..color = isConnectedToHovered
            ? AppColors.primary
            : AppColors.textMain.withValues(alpha: 0.35)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p1, isConnectedToHovered ? 3.0 : 1.8, terminalPaint);
      canvas.drawCircle(p2, isConnectedToHovered ? 3.0 : 1.8, terminalPaint);

      if (isConnectedToHovered) {
        final Paint terminalRingPaint = Paint()
          ..color = AppColors.primary.withValues(alpha: 0.35)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;
        canvas.drawCircle(p1, 5.5, terminalRingPaint);
        canvas.drawCircle(p2, 5.5, terminalRingPaint);
      }

      // Dual Traveling Signal Pulses with Comet Tails
      // Calm, slow traveling speed multiplier
      final double speedMult = isConnectedToHovered ? 1.15 : 1.0;
      final double baseT = (pulseProgress * speedMult + (i * 0.07)) % 1.0;

      // Two pulses running along the wire offset by 0.5
      final List<double> pulsePhases = [baseT, (baseT + 0.5) % 1.0];

      for (final t in pulsePhases) {
        Offset getBezierPoint(double progress) {
          final double clamped = progress.clamp(0.0, 1.0);
          final double invT = 1.0 - clamped;
          final double x =
              invT * invT * p1.dx + 2 * invT * clamped * midX + clamped * clamped * p2.dx;
          final double y =
              invT * invT * p1.dy + 2 * invT * clamped * midY + clamped * clamped * p2.dy;
          return Offset(x, y);
        }

        // Draw 3 comet tail particles trailing behind the pulse
        final double cometRadius = isConnectedToHovered ? 3.6 : 2.4;
        final Color baseColor =
            isConnectedToHovered ? AppColors.primary : AppColors.textMain;

        const tailOffsets = [0.024, 0.048, 0.072];
        const tailAlphas = [0.45, 0.28, 0.14];
        const tailRadiusMults = [0.75, 0.55, 0.35];

        for (int k = 0; k < tailOffsets.length; k++) {
          final double tailT = t - tailOffsets[k];
          if (tailT > 0.0 && tailT < 1.0) {
            final Offset tailPt = getBezierPoint(tailT);
            final Paint tailPaint = Paint()
              ..color = baseColor.withValues(
                alpha: (isConnectedToHovered ? 0.85 : 0.60) * tailAlphas[k],
              )
              ..style = PaintingStyle.fill;
            canvas.drawCircle(
              tailPt,
              cometRadius * tailRadiusMults[k],
              tailPaint,
            );
          }
        }

        // Main traveling pulse dot
        final Offset pt = getBezierPoint(t);
        final Paint pulsePaint = Paint()
          ..color = isConnectedToHovered
              ? AppColors.primary
              : AppColors.textMain.withValues(alpha: 0.65)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(pt, cometRadius, pulsePaint);

        // Active ripple ring around the signal when connected
        if (isConnectedToHovered) {
          final double rippleRadius =
              cometRadius + 2.0 + math.sin((pulseProgress * 6 * math.pi) + i) * 1.4;
          final Paint ripplePaint = Paint()
            ..color = AppColors.primary.withValues(alpha: 0.35)
            ..strokeWidth = 1.0
            ..style = PaintingStyle.stroke;
          canvas.drawCircle(pt, rippleRadius, ripplePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AdvancedSynapticPainter oldDelegate) {
    return oldDelegate.pulseProgress != pulseProgress ||
        oldDelegate.hoveredNodeId != hoveredNodeId;
  }
}

/// Interactive neural node with bigger skill text, no subtitle,
/// and smoothly animated icon reveal on hover.
class _CoolNeuralNode extends StatelessWidget {
  final _NeuralNodeData node;
  final bool isHovered;
  final bool isRelated;
  final bool isMobile;
  final ValueChanged<bool> onHover;

  const _CoolNeuralNode({
    required this.node,
    required this.isHovered,
    required this.isRelated,
    this.isMobile = false,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isHovered || isRelated;
    final bool isCore = node.isCore;
    final bool isLongLabel = node.label.length > 15;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: isHovered ? 1.0 : (isRelated ? 0.30 : 0.0),
        ),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        builder: (context, anim, child) {
          final double scale =
              1.0 + (isHovered ? 0.12 : (isRelated ? 0.04 : 0.0)) * anim;
          final double tiltAngle =
              (node.id.hashCode.isEven ? 0.025 : -0.025) * anim;
          final double translateY = -4.0 * anim;

          return Transform(
            transform: Matrix4.identity()
              ..translateByDouble(0.0, translateY, 0.0, 1.0)
              ..rotateZ(tiltAngle)
              ..scaleByDouble(scale, scale, 1.0, 1.0),
            alignment: Alignment.center,
            child: CustomPaint(
              painter: SketchBorderPainter(
                strokeWidth: isCore ? 2.4 : (isHovered ? 2.0 : 1.5),
                borderRadius: isCore ? 20 : 14,
                wobble: 1.4,
                seed: node.id.hashCode.abs() % 40 + 7,
                backgroundColor: AppColors.background,
                isHovered: active,
                zigzagProgress: 0.35 * anim,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile
                      ? (isLongLabel ? 7 : (isCore ? 10 : 8))
                      : (isCore ? 14 : 11),
                  vertical: isMobile ? (isCore ? 5 : 4) : (isCore ? 8 : 6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Smoothly revealed icon on hover
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: anim.clamp(0.0, 1.0),
                        child: Opacity(
                          opacity: anim.clamp(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 5.0 * anim.clamp(0.0, 1.0),
                            ),
                            child: Transform.scale(
                              scale: 0.5 + 0.5 * anim.clamp(0.0, 1.0),
                              child: Icon(
                                node.icon,
                                size: isMobile
                                    ? (isCore ? 15 : 12)
                                    : (isCore ? 19 : 16),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Skill Name - Prominent, clean text with Patrick Hand
                    Text(
                      node.label,
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: isMobile
                            ? (isLongLabel ? 12.0 : (isCore ? 14.5 : 13.0))
                            : (isCore ? 18.0 : 16.0),
                        fontWeight:
                            isCore ? FontWeight.w900 : FontWeight.w800,
                        color: AppColors.textMain,
                        letterSpacing: isLongLabel ? 0.2 : 0.5,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 3. WINDING HAND-DRAWN ROADMAP (NOT STRAIGHT, NO POINTS, NO ICONS, NO OVERFLOW)
// ═══════════════════════════════════════════════════════════════════════════

class _RoadmapMilestone {
  final String numeral;
  final String label;
  final String description;
  final bool isLeft;

  const _RoadmapMilestone({
    required this.numeral,
    required this.label,
    required this.description,
    required this.isLeft,
  });
}

class _WindingRoadmapSection extends StatelessWidget {
  final bool isMobile;

  const _WindingRoadmapSection({required this.isMobile});

  static const List<_RoadmapMilestone> _milestones = [
    _RoadmapMilestone(
      numeral: '1+ Year',
      label: 'Hands-On Experience',
      description: 'Building clean, reliable Flutter apps every single day.',
      isLeft: true,
    ),
    _RoadmapMilestone(
      numeral: '3+ Apps',
      label: 'Successfully Released',
      description:
          'Taking real products from a blank canvas into users\' hands.',
      isLeft: false,
    ),
    _RoadmapMilestone(
      numeral: '1.1K+',
      label: 'Community Followers',
      description: 'Sharing my work, design tips, and coding journey online.',
      isLeft: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pure text header
        const Text(
          'PROVEN TRACK RECORD',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 28),

        // Winding Roadmap without points and without overflow
        if (isMobile)
          _buildMobileWindingRoadmap()
        else
          _buildDesktopWindingRoadmap(),
      ],
    );
  }

  Widget _buildDesktopWindingRoadmap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        const double itemHeight = 130.0;
        final double totalHeight = _milestones.length * itemHeight;

        return SizedBox(
          width: w,
          height: totalHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Winding S-Curved Dashed Pencil Road flowing smoothly in center (NO points, NO overflow)
              Positioned.fill(
                child: CustomPaint(
                  painter: _WindingRoadmapPainter(itemCount: _milestones.length, itemHeight: itemHeight, isMobile: false),
                ),
              ),

              // 2. Milestones placed along the winding path (NO points, NO hover effects)
              ...List.generate(_milestones.length, (index) {
                final milestone = _milestones[index];
                final bool isLeft = milestone.isLeft;
                final double top = index * itemHeight + 10;

                return Positioned(
                  top: top,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      // Left content box
                      Expanded(
                        child: isLeft
                            ? Padding(
                                padding: const EdgeInsets.only(right: 36.0),
                                child: _MilestoneStaticContent(
                                  data: milestone,
                                  alignRight: true,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),

                      // Center road clearance (No point/marker)
                      const SizedBox(width: 40),

                      // Right content box
                      Expanded(
                        child: !isLeft
                            ? Padding(
                                padding: const EdgeInsets.only(left: 36.0),
                                child: _MilestoneStaticContent(
                                  data: milestone,
                                  alignRight: false,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileWindingRoadmap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        const double itemHeight = 118.0;
        final double totalHeight = _milestones.length * itemHeight;

        return SizedBox(
          width: w,
          height: totalHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Mobile winding dashed curve along left margin (NO points, NO overflow)
              Positioned.fill(
                child: CustomPaint(
                  painter: _WindingRoadmapPainter(itemCount: _milestones.length, itemHeight: itemHeight, isMobile: true),
                ),
              ),

              // Milestones arranged along winding path (NO points, NO hover effects)
              ...List.generate(_milestones.length, (index) {
                final milestone = _milestones[index];
                final double top = index * itemHeight;

                return Positioned(
                  top: top,
                  left: 38,
                  right: 8,
                  child: _MilestoneStaticContent(
                    data: milestone,
                    alignRight: false,
                    isMobile: true,
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

/// Winding dashed pencil road painter (strictly bounded, NO points, NO overflow).
class _WindingRoadmapPainter extends CustomPainter {
  final int itemCount;
  final double itemHeight;
  final bool isMobile;

  _WindingRoadmapPainter({
    required this.itemCount,
    required this.itemHeight,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (itemCount <= 1) return;
    final double w = size.width;
    if (w <= 0) return;

    final Path roadPath = Path();

    if (!isMobile) {
      final double midX = w * 0.5;
      roadPath.moveTo(midX - 30.0, 24.0);

      for (int i = 0; i < itemCount - 1; i++) {
        final double currX = (i.isEven) ? midX - 30.0 : midX + 30.0;
        final double nextX = ((i + 1).isEven) ? midX - 30.0 : midX + 30.0;
        final double currY = i * itemHeight + 24.0;
        final double nextY = (i + 1) * itemHeight + 24.0;
        final double midY = (currY + nextY) * 0.5;

        roadPath.cubicTo(
          currX + (i.isEven ? 45.0 : -45.0),
          midY - 8,
          nextX + (i.isEven ? -45.0 : 45.0),
          midY + 8,
          nextX,
          nextY,
        );
      }

      final Paint shadowPaint = Paint()
        ..color = AppColors.textMain.withValues(alpha: 0.12)
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      _drawDashed(canvas, roadPath, shadowPaint, 7, 6);

      final Paint mainPaint = Paint()
        ..color = AppColors.textMain.withValues(alpha: 0.65)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      _drawDashed(canvas, roadPath, mainPaint, 7, 6);
    } else {
      roadPath.moveTo(16.0, 16.0);
      for (int i = 0; i < itemCount - 1; i++) {
        final double currX = (i.isEven) ? 16.0 : 26.0;
        final double nextX = ((i + 1).isEven) ? 16.0 : 26.0;
        final double currY = i * itemHeight + 16.0;
        final double nextY = (i + 1) * itemHeight + 16.0;
        final double midY = (currY + nextY) * 0.5;

        roadPath.cubicTo(
          currX + (i.isEven ? 10 : -10),
          midY - 6,
          nextX + (i.isEven ? -10 : 10),
          midY + 6,
          nextX,
          nextY,
        );
      }

      final Paint roadPaint = Paint()
        ..color = AppColors.textMain.withValues(alpha: 0.55)
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      _drawDashed(canvas, roadPath, roadPaint, 6, 5);
    }
  }

  void _drawDashed(Canvas canvas, Path path, Paint paint, double dash, double space) {
    for (final PathMetric metric in path.computeMetrics()) {
      double d = 0.0;
      while (d < metric.length) {
        final double end = math.min(d + dash, metric.length);
        canvas.drawPath(metric.extractPath(d, end), paint);
        d += dash + space;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WindingRoadmapPainter oldDelegate) =>
      oldDelegate.itemCount != itemCount ||
      oldDelegate.itemHeight != itemHeight ||
      oldDelegate.isMobile != isMobile;
}

class _MilestoneStaticContent extends StatelessWidget {
  final _RoadmapMilestone data;
  final bool alignRight;
  final bool isMobile;

  const _MilestoneStaticContent({
    required this.data,
    required this.alignRight,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final crossAlign =
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textAlign = alignRight ? TextAlign.right : TextAlign.left;

    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        // Big Bold Milestone Numeral (Grounded directly on paper, No Hover)
        Text(
          data.numeral,
          textAlign: textAlign,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: isMobile ? 24 : 30,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 3),

        // Milestone Title
        Text(
          data.label,
          textAlign: textAlign,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 3),

        // Description / Narrative
        Text(
          data.description,
          textAlign: textAlign,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: isMobile ? 12 : 13,
            color: AppColors.textSecondary,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}