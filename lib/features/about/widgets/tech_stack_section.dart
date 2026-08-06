import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/theme.dart';
import '../../../widgets/responsive_text.dart';
import '../about_controller.dart';


class TechStackSection extends StatelessWidget {
  final bool isMobile;

  const TechStackSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> techCategories = {
      'Languages': [
        {'name': 'Dart', 'icon': Icons.code, 'color': Colors.cyanAccent},
      ],
      'Frameworks & Tools': [
        {'name': 'Flutter', 'icon': Icons.phone_iphone, 'color': Colors.blueAccent},
        {'name': 'Android Studio', 'icon': Icons.laptop, 'color': Colors.green},
        {'name': 'GetX', 'icon': Icons.bolt, 'color': Colors.deepPurpleAccent},
        {'name': 'Provider', 'icon': Icons.account_tree, 'color': Colors.lightBlue},
      ],
      'Backend & DB': [
        {'name': 'Firebase', 'icon': Icons.cloud, 'color': Colors.orangeAccent},
        {'name': 'Supabase', 'icon': Icons.data_usage, 'color': Colors.greenAccent},
        {'name': 'Isar', 'icon': Icons.storage, 'color': Colors.pinkAccent},
        {'name': 'REST API', 'icon': Icons.http, 'color': Colors.orange},
      ],
      'Design & Version': [
        {'name': 'Figma', 'icon': Icons.draw, 'color': Colors.pink},
        {'name': 'Git/GitHub', 'icon': Icons.merge_type, 'color': Colors.white},
        {'name': 'Antigravity', 'icon': Icons.rocket_launch, 'color': Colors.deepOrangeAccent},
      ],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: techCategories.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                entry.key,
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white, // All subheadings use the same neutral white color
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: isMobile ? 12 : 16,
                runSpacing: isMobile ? 12 : 16,
                children: entry.value.map((tech) {
                  return _TechChip(
                    name: tech['name'],
                    icon: tech['icon'],
                    hoverColor: tech['color'],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color hoverColor;

  const _TechChip({
    required this.name,
    required this.icon,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    final String hoverKey = 'tech_chip_$name';

    return MouseRegion(
      onEnter: (_) => controller.setHovered(hoverKey, true),
      onExit: (_) => controller.setHovered(hoverKey, false),
      child: Obx(() {
        final bool isHovered = controller.isHovered(hoverKey);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.surfaceInner : AppColors.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isHovered ? hoverColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: hoverColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                    )
                  ]
                : AppColors.neumorphicShadows(distance: 4, blur: 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isHovered ? hoverColor : Colors.white70,
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isHovered ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
