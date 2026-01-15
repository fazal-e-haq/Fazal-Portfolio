import 'package:flutter/material.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 26),
          child: SingleChildScrollView(child: Column(children: [Text('ta')])),
        ),
      ),
    );
  }
}
