import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';

// This is the "Home" or "Hero" section that visitors see first
class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.85,
          height: size.height * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Text content
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RepaintBoundary(
                      child: ResponsiveText(
                        'Hello,i am',
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white70,
                          wordSpacing: 5,
                        ),
                        minFontSize: 13,
                        maxFontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 1),
                    // PERFORMANCE: Wrapped in RepaintBoundary
                    RepaintBoundary(
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        stopPauseOnTap: false,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          ScrambleAnimatedText(
                            speed: const Duration(milliseconds: 300),
                            'FAZAL-E-HAQ',
                            textAlign: TextAlign.start,
                            textStyle: const TextStyle(
                              fontSize: 65,
                              wordSpacing: 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // PERFORMANCE: Wrapped in RepaintBoundary
                    RepaintBoundary(
                      child: AnimatedTextKit(
                        repeatForever: true,
                        stopPauseOnTap: false,
                        isRepeatingAnimation: true,
                        pause: const Duration(seconds: 3),
                        animatedTexts: [
                          TyperAnimatedText(
                            textAlign: TextAlign.start,
                            'UI/UX Designer',
                            textStyle: const TextStyle(
                              letterSpacing: 5,
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TyperAnimatedText(
                            textAlign: TextAlign.start,
                            'Flutter Developer',
                            textStyle: const TextStyle(
                              fontSize: 35,
                              letterSpacing: 5,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Right side: Profile image
              Expanded(
                flex: 2,
                child: RepaintBoundary(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withValues(alpha: 0.2),
                          blurRadius: 50,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/Images/my_portfolio_pic.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
