import 'package:fazal_portfolio/presentation/Pages/computer/about_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/contact_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/home_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/skills_section.dart';
import 'package:fazal_portfolio/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';

class ComputerHomePage extends StatefulWidget {
  const ComputerHomePage({super.key});

  @override
  State<ComputerHomePage> createState() => _ComputerHomePageState();
}

class _ComputerHomePageState extends State<ComputerHomePage> {
  List<Widget> sections = [
    HomeSection(),
    AboutSection(),
    SkillsSection(),
    ContactSection(),
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: appBar(
          onTap: () {
            controller.animateTo(
              1,
              duration: Duration(milliseconds: 600),
              curve: Curves.ease,
            );
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: controller,
          scrollDirection: .vertical,
          children: [
            HomeSection(),
            AboutSection(),
            SkillsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
