import 'dart:math';
import 'package:fazal_portfolio/presentation/pages/sections/about_section.dart';
import 'package:fazal_portfolio/presentation/pages/sections/home_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/star_model.dart';
import '../../providers/navigation_provider.dart';

import '../widgets/nav_bar_widget.dart';
import '../widgets/start_widget.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  final Random random = Random();

  late final List<Star> stars;

  @override
  void initState() {
    super.initState();

    final nav = context.read<NavigationProvider>();

    nav.pageController.addListener(() {
      nav.updatePageOffset(nav.pageController.page ?? 0.0);
    });

    stars = List.generate(
      250,
          (i) => Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 2.5 + 0.5,
        baseOpacity: random.nextDouble() * 0.7 + 0.3,
        phase: random.nextDouble() * 2 * pi,
        speed: random.nextDouble() * 0.5 + 0.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();

    return Stack(
      children: [
        // ⭐ GPU STAR LAYER
        StarFieldPainterWidget(
          offset: nav.pageOffset,
        ),

        // UI LAYER
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: NavBarWidget(),
          ),
          body: PageView(
            controller: nav.pageController,
            onPageChanged: nav.updateIndexFromScroll,
            children: const [
              HomeSection(),
              AboutSection(),
            ],
          ),
        ),
      ],
    );
  }
}