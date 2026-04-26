import 'dart:ui';
import 'package:fazal_portfolio/presentation/Pages/computer/about_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/contact_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/home_section.dart';
import 'package:fazal_portfolio/presentation/Pages/computer/project_section.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ComputerHomePage extends StatefulWidget {
  const ComputerHomePage({super.key});

  @override
  State<ComputerHomePage> createState() => _ComputerHomePageState();
}

class _ComputerHomePageState extends State<ComputerHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: preferredSizeAppBar(size, context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff07C8F9), Color(0xff0D41E1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 125),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeSection(key: homeKey),
                AboutSection(key: aboutKey),
                ProjectSection(key: projectKey),
                ContactSection(key: contactKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App Bar
  PreferredSize preferredSizeAppBar(Size size, BuildContext context) {
    bool isTab = size.width <= 1200;
    return PreferredSize(
      preferredSize: const Size(
        double.infinity,
        120,
      ), // Increased height for glow
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 120,
        title: Container(
          width: isTab ? size.width * 0.47 : size.width * 0.3, // Narrower width
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue.shade900, // Royal Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade900,
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(3, 3),
              ),
              BoxShadow(
                color: Colors.orange.shade900,
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(-3, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Buttons closer together
            children: [
              appBarButton('Home', homeKey),
              const SizedBox(width: 8),
              appBarButton('About', aboutKey),
              const SizedBox(width: 8),
              appBarButton('Projects', projectKey),
              const SizedBox(width: 8),
              appBarButton('Contact', contactKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarButton(String title, GlobalKey key) {
    return ButtonWidget(
      onPressed: () => scrollToSection(key),
      backgroundColor: const Color(0xFF001F9F),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      child: Text(title),
    );
  }
}
