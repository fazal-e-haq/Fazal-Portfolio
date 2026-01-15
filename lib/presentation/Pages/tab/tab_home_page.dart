import 'package:fazal_portfolio/presentation/widgets/neumorphism_widget.dart';
import 'package:flutter/material.dart';

class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
