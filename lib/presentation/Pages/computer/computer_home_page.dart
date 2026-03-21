import 'package:fazal_portfolio/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'home_section.dart';

class ComputerHomePage extends StatefulWidget {
  const ComputerHomePage({super.key});

  @override
  State<ComputerHomePage> createState() => _ComputerHomePageState();
}

class _ComputerHomePageState extends State<ComputerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(preferredSize: .fromHeight(85), child: MyAppBar()),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff07C8F9), Color(0xff0D41E1)],
              begin: .topLeft,
              end: .bottomRight,
            ),
          ),
          child: HomeSection(),
        ),
      ),
    );
  }
}
