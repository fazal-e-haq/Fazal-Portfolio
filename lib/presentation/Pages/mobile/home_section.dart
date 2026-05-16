import 'dart:js_interop';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../computer/home_section.dart';
@JS('window.open')
external JSAny? openWindow(JSString url, JSString target);
class MobileHomeSection extends StatelessWidget {
  const MobileHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    void downloadResume() {
      openWindow('assets/Resume.pdf'.toJS, '_blank'.toJS);
    }

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height:
            size.height, // Keep it full screen height for the PageView effect
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The background image with fade/blur effect at the bottom
            Positioned(
              top: 0,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                    stops: [0.6, 1.0],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/Images/my_portfolio_pic.png',
                  height:
                      size.height * 0.62, // Slightly taller to be more prominent
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Main content card positioned to overlap the image
            Positioned(
              top: size.height * 0.6,
              left: size.width * 0.05,
              child: InfoCardWidget(
                width: size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const RepaintBoundary(
                      child: ResponsiveText(
                        'Hello,i am',
                        style: TextStyle(letterSpacing: 4, color: Colors.white70),
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RepaintBoundary(
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          // My name - Changed from white12 to white for visibility
                          ScrambleAnimatedText(
                            speed: const Duration(milliseconds: 300),
                            'FAZAL-E-HAQ',
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                    ),

                   // My skills - Wrapped in RepaintBoundary
                    RepaintBoundary(
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(seconds: 3),
                        animatedTexts: [
                          TyperAnimatedText(
                            textAlign: TextAlign.center,
                            'UI/UX Designer',
                            textStyle: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 5,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TyperAnimatedText(
                            textAlign: TextAlign.center,
                            'Flutter Developer',
                            textStyle: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 5,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ButtonWidget(
                      onPressed: downloadResume,
                      icon: const Icon(Icons.arrow_downward),
                      child: Text('Download Resume'),
                    ),
                  ],
                ),
              ),
            ),

            // Scroll indicator arrow at the bottom
            Positioned(bottom: 20, child: RepaintBoundary(child: _AnimatedArrowIndicator())),
          ],
        ),
      ),
    );
  }
}

// Animated arrow
class _AnimatedArrowIndicator extends StatefulWidget {
  @override
  State<_AnimatedArrowIndicator> createState() =>
      _AnimatedArrowIndicatorState();
}

class _AnimatedArrowIndicatorState extends State<_AnimatedArrowIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blueAccent,
            size: 60,
          ),
        );
      },
    );
  }
}
