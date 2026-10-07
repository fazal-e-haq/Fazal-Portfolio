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
        {'name': 'Dart', 'icon': Icons.code_outlined},
      ],
      'Frameworks & Tools': [
        {'name': 'Flutter', 'icon': Icons.phone_iphone_outlined},
        {'name': 'Android Studio', 'icon': Icons.laptop_outlined},
        {'name': 'GetX', 'icon': Icons.bolt_outlined},
        {'name': 'Provider', 'icon': Icons.account_tree_outlined},
      ],
      'Backend & DB': [
        {'name': 'Firebase', 'icon': Icons.cloud_outlined},
        {'name': 'Supabase', 'icon': Icons.data_usage_outlined},
        {'name': 'Isar', 'icon': Icons.storage_outlined},
        {'name': 'REST API', 'icon': Icons.http_outlined},
      ],
      'Design & Version': [
        {'name': 'Figma', 'icon': Icons.draw_outlined},
        {'name': 'Git/GitHub', 'icon': Icons.merge_type_outlined},
        {'name': 'Antigravity', 'icon': Icons.rocket_launch_outlined},
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
                  fontFamily: 'Patrick Hand',
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
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

  const _TechChip({
    required this.name,
    required this.icon,
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
          transform: Matrix4.translationValues(isHovered ? -2.0 : 0.0, isHovered ? -2.0 : 0.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.textMain,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.textMain,
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
