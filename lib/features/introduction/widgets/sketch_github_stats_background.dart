import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/themes/theme.dart';
import '../../../../widgets/sketch_painter.dart';

/// A handcrafted pencil-sketch GitHub Contribution Heatmap backdrop.
/// Designed to sit directly in the background of Fazal's portrait,
/// matching the Hand-Drawn Brutalism sketchbook theme with pure charcoal outlines.
class SketchGithubStatsBackground extends StatelessWidget {
  const SketchGithubStatsBackground({
    super.key,
    required this.width,
    required this.height,
    this.isMobile = false,
  });

  final double width;
  final double height;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    // Responsive box size and column count based on available width
    final double boxSize = isMobile ? 9.5 : 13.0;
    final double boxGap = isMobile ? 2.5 : 3.8;
    const int rows = 7; // Sunday - Saturday

    // Calculate maximum columns that fit comfortably within width
    final double labelGutter = isMobile ? 44.0 : 66.0;
    final double usableGridWidth = (width - labelGutter).clamp(140.0, 600.0);
    final int cols = ((usableGridWidth + boxGap) / (boxSize + boxGap)).floor().clamp(12, 28);
    final double actualGridWidth = cols * boxSize + (cols - 1) * boxGap;
    final double actualGridHeight = rows * boxSize + (rows - 1) * boxGap;

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: CustomPaint(
          painter: const SketchBorderPainter(
            color: Color(0xCC1A1A1A),
            strokeWidth: 1.8,
            borderRadius: 14.0,
            wobble: 1.6,
            seed: 77,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 8.0 : 16.0,
              vertical: isMobile ? 6.0 : 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Top Header Row: Sketched commit icon + "github contributions" + commit count
                _buildHeader(isMobile),

                // 2. Month Labels Row
                _buildMonthLabels(actualGridWidth, isMobile),

                // 3. Central Grid Area: Day labels on left + Contribution Boxes
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left day labels: Mon, Wed, Fri
                        _buildDayLabels(actualGridHeight, isMobile),
                        const SizedBox(width: 5.0),
                        // Contribution Boxes Matrix
                        SizedBox(
                          width: actualGridWidth,
                          height: actualGridHeight,
                          child: CustomPaint(
                            painter: _GithubBoxesPainter(
                              cols: cols,
                              rows: rows,
                              boxSize: boxSize,
                              boxGap: boxGap,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Bottom Legend Row: Activity overview + Less ... More
                _buildFooter(boxSize, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: const Size(12, 12),
                painter: _GitBranchIconPainter(),
              ),
              const SizedBox(width: 6.0),
              Flexible(
                child: Text(
                  'github contributions',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Patrick Hand',
                    fontSize: isMobile ? 11.0 : 13.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xDD1A1A1A),
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isMobile)
          const Text(
            '2,840+ commits / year',
            style: TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Color(0xAA1A1A1A),
            ),
          ),
      ],
    );
  }

  Widget _buildMonthLabels(double gridWidth, bool isMobile) {
    final List<String> months = isMobile
        ? const ['Jan', 'Apr', 'Jul', 'Oct', 'Dec']
        : const [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
          ];

    return Padding(
      padding: EdgeInsets.only(left: isMobile ? 22.0 : 32.0, top: 1.0),
      child: SizedBox(
        width: gridWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: months.map((m) {
            return Text(
              m,
              style: TextStyle(
                fontFamily: 'Patrick Hand',
                fontSize: isMobile ? 9.0 : 11.0,
                color: const Color(0x881A1A1A),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDayLabels(double gridHeight, bool isMobile) {
    final TextStyle dayStyle = TextStyle(
      fontFamily: 'Patrick Hand',
      fontSize: isMobile ? 8.5 : 10.5,
      color: const Color(0x881A1A1A),
    );

    return SizedBox(
      height: gridHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 1),
          Text('Mon', style: dayStyle),
          Text('Wed', style: dayStyle),
          Text('Fri', style: dayStyle),
          const SizedBox(height: 1),
        ],
      ),
    );
  }

  Widget _buildFooter(double boxSize, bool isMobile) {
    final TextStyle legendStyle = TextStyle(
      fontFamily: 'Patrick Hand',
      fontSize: isMobile ? 8.5 : 10.5,
      color: const Color(0x881A1A1A),
    );

    final double sampleBoxSize = (boxSize * 0.85).clamp(7.5, 11.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'daily code habit',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Patrick Hand',
              fontSize: isMobile ? 9.5 : 11.5,
              color: const Color(0x771A1A1A),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Less', style: legendStyle),
            const SizedBox(width: 3.0),
            for (int lvl = 0; lvl <= 4; lvl++) ...[
              CustomPaint(
                size: Size(sampleBoxSize, sampleBoxSize),
                painter: _SingleSketchBoxPainter(level: lvl),
              ),
              if (lvl < 4) const SizedBox(width: 2.5),
            ],
            const SizedBox(width: 3.0),
            Text('More', style: legendStyle),
          ],
        ),
      ],
    );
  }
}

/// Custom painter rendering the matrix of hand-drawn GitHub contribution boxes.
class _GithubBoxesPainter extends CustomPainter {
  final int cols;
  final int rows;
  final double boxSize;
  final double boxGap;

  const _GithubBoxesPainter({
    required this.cols,
    required this.rows,
    required this.boxSize,
    required this.boxGap,
  });

  /// Deterministic activity level generator to simulate realistic GitHub heatmap
  /// streaks without any frame-to-frame flickering.
  int _getActivityLevel(int col, int row) {
    // Golden ratio hash for natural pseudo-random distribution
    final double raw = (math.sin(col * 12.9898 + row * 78.233 + 42.0) * 43758.5453) % 1.0;
    final double val = raw.abs();

    // Weekdays (Mon-Fri, rows 1-5) have higher commit probability
    final bool isWeekday = row >= 1 && row <= 5;
    final double threshold = isWeekday ? 0.22 : 0.45;

    if (val < threshold) return 0; // Inactive
    if (val < threshold + 0.26) return 1; // Light
    if (val < threshold + 0.50) return 2; // Medium
    if (val < threshold + 0.70) return 3; // High
    return 4; // Peak
  }

  @override
  void paint(Canvas canvas, Size size) {
    int boxSeed = 100;

    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        final double x = c * (boxSize + boxGap);
        final double y = r * (boxSize + boxGap);
        final Rect rect = Rect.fromLTWH(x, y, boxSize, boxSize);

        final int level = _getActivityLevel(c, r);
        _drawSketchBox(canvas, rect, level, boxSeed++);
      }
    }
  }

  void _drawSketchBox(Canvas canvas, Rect rect, int level, int seed) {
    // Deterministic corner tremor (0.3px)
    final double j1 = math.sin(seed * 1.3) * 0.35;
    final double j2 = math.cos(seed * 2.1) * 0.35;
    final double j3 = math.sin(seed * 3.7) * 0.35;
    final double j4 = math.cos(seed * 4.9) * 0.35;

    final Path boxPath = Path();
    const double rad = 1.8;
    boxPath.moveTo(rect.left + rad + j1, rect.top);
    boxPath.lineTo(rect.right - rad + j2, rect.top);
    boxPath.quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + rad);
    boxPath.lineTo(rect.right, rect.bottom - rad + j3);
    boxPath.quadraticBezierTo(rect.right, rect.bottom, rect.right - rad, rect.bottom);
    boxPath.lineTo(rect.left + rad + j4, rect.bottom);
    boxPath.quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - rad);
    boxPath.lineTo(rect.left, rect.top + rad + j1);
    boxPath.quadraticBezierTo(rect.left, rect.top, rect.left + rad + j1, rect.top);
    boxPath.close();

    // Stroke styling strictly in charcoal black
    double strokeWidth;
    double alpha;

    switch (level) {
      case 0:
        strokeWidth = 0.85;
        alpha = 0.20; // Faint outline
        break;
      case 1:
        strokeWidth = 1.10;
        alpha = 0.45; // Crisp sketch line
        break;
      case 2:
        strokeWidth = 1.35;
        alpha = 0.70; // Bolder outline
        break;
      case 3:
        strokeWidth = 1.60;
        alpha = 0.90; // Dark outline
        break;
      case 4:
      default:
        strokeWidth = 1.85;
        alpha = 1.00; // Solid ink outline
        break;
    }

    final Paint outlinePaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: alpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(boxPath, outlinePaint);

    // Hand-drawn pencil hatch lines inside active boxes (Strictly Black!)
    if (level >= 2) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 2 ? 0.35 : (level == 3 ? 0.65 : 0.85),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.95
        ..strokeCap = StrokeCap.round;

      // Primary diagonal pencil stroke
      canvas.drawLine(
        Offset(rect.left + 2.2, rect.bottom - 2.2),
        Offset(rect.right - 2.2, rect.top + 2.2),
        hatchPaint,
      );
    }

    if (level >= 3) {
      final Paint hatchPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(
          alpha: level == 3 ? 0.60 : 0.85,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.90
        ..strokeCap = StrokeCap.round;

      // Secondary parallel diagonal strokes
      canvas.drawLine(
        Offset(rect.left + 2.0, rect.top + rect.height * 0.45),
        Offset(rect.left + rect.width * 0.55, rect.top + 2.0),
        hatchPaint,
      );
      canvas.drawLine(
        Offset(rect.left + rect.width * 0.45, rect.bottom - 2.0),
        Offset(rect.right - 2.0, rect.top + rect.height * 0.55),
        hatchPaint,
      );
    }

    if (level >= 4) {
      final Paint crossPaint = Paint()
        ..color = const Color(0xFF1A1A1A).withValues(alpha: 0.75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.90
        ..strokeCap = StrokeCap.round;

      // Counter-diagonal cross-hatch for peak intensity
      canvas.drawLine(
        Offset(rect.left + 2.2, rect.top + 2.2),
        Offset(rect.right - 2.2, rect.bottom - 2.2),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GithubBoxesPainter oldDelegate) {
    return oldDelegate.cols != cols ||
        oldDelegate.rows != rows ||
        oldDelegate.boxSize != boxSize ||
        oldDelegate.boxGap != boxGap;
  }
}

/// Helper painter for the single sample box in the legend
class _SingleSketchBoxPainter extends CustomPainter {
  final int level;

  const _SingleSketchBoxPainter({required this.level});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const painter = _GithubBoxesPainter(cols: 1, rows: 1, boxSize: 10, boxGap: 0);
    painter._drawSketchBox(canvas, rect, level, level * 33 + 7);
  }

  @override
  bool shouldRepaint(covariant _SingleSketchBoxPainter oldDelegate) {
    return oldDelegate.level != level;
  }
}

/// Sketched git branch / commit icon in pure charcoal ink
class _GitBranchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xCC1A1A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final Paint nodePaint = Paint()
      ..color = const Color(0xDD1A1A1A)
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;

    // Main commit trunk
    canvas.drawLine(Offset(w * 0.3, h * 0.25), Offset(w * 0.3, h * 0.8), linePaint);

    // Branch curve
    final Path branch = Path()
      ..moveTo(w * 0.3, h * 0.55)
      ..quadraticBezierTo(w * 0.65, h * 0.55, w * 0.75, h * 0.25);
    canvas.drawPath(branch, linePaint);

    // Commit nodes
    canvas.drawCircle(Offset(w * 0.3, h * 0.25), 1.8, nodePaint);
    canvas.drawCircle(Offset(w * 0.3, h * 0.8), 1.8, nodePaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.25), 1.8, nodePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
