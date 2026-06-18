import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showSubtitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 850;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  child: Center(
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: false,
                      onNext: (index, isLast) {
                        if (mounted) {
                          setState(() {
                            _showSubtitle = true;
                          });
                        }
                        final provider = context.read<SplashProvider>();
                        Future.delayed(const Duration(milliseconds: 2500), () {
                          if (mounted) {
                            provider.setIntro();
                          }
                        });
                      },
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'I build digital products that solve real problems',
                          speed: const Duration(milliseconds: 70),
                          textAlign: TextAlign.center,
                          curve: Curves.decelerate,
                          textStyle: GoogleFonts.unbounded(
                            color: Colors.deepOrange,
                            fontSize: isMobile ? 14 : 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: _showSubtitle ? 1 : 0,
                  child: Text(
                    "Let me introduce myself",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      letterSpacing: 1,
                      fontSize: isMobile ? 12 : 16,
                      wordSpacing: 1,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
