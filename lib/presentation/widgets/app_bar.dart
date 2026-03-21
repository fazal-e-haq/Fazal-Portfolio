import 'package:fazal_portfolio/presentation/widgets/hover_effect_button.dart';
import 'package:fazal_portfolio/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 530,
        padding: .symmetric(vertical: 16),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff07C8F9), Color(0xff0D41E1)],
            begin: .topLeft,
            end: .bottomRight,
          ),
          borderRadius: .circular(50),
        ),

        child: Row(
          mainAxisAlignment: .center,
          children: [
            HoverEffectButton(text: Text('H o m e')),
            HoverEffectButton(text: Text('A b o u t')),
            HoverEffectButton(text: Text('P r o j e c t s')),
            HoverEffectButton(text: Text('C o n t a c t')),
          ],
        ),
      ),
    );
  }
}
