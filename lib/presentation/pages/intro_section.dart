import 'package:fazal_portfolio/presentation/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: NavBarWidget(),
      ),
    );
  }
}
