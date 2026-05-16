import 'dart:js_interop';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

@JS('window.open')
external JSAny? openWindow(JSString url, JSString target);

class TabletHomeSection extends StatelessWidget {
  const TabletHomeSection({super.key});
  void downloadResume() {
    openWindow('assets/Resume.pdf'.toJS, '_blank'.toJS);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool useVertical = constraints.maxWidth < 700;

              Widget textContent = Column(
                crossAxisAlignment: useVertical
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RepaintBoundary(
                    child: ResponsiveText(
                      'Hello,i am',
                      style: TextStyle(letterSpacing: 2, color: Colors.white70),
                      minFontSize: 14,
                      maxFontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RepaintBoundary(
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        ScrambleAnimatedText(
                          speed: const Duration(milliseconds: 300),
                          'FAZAL-E-HAQ',
                          textAlign: useVertical
                              ? TextAlign.center
                              : TextAlign.start,
                          textStyle: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  RepaintBoundary(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(seconds: 3),
                      animatedTexts: [
                        TyperAnimatedText(
                          textAlign: useVertical
                              ? TextAlign.center
                              : TextAlign.start,
                          'UI/UX Designer',
                          textStyle: const TextStyle(
                            fontSize: 25,
                            letterSpacing: 5,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent,
                          ),
                        ),
                        TyperAnimatedText(
                          textAlign: useVertical
                              ? TextAlign.center
                              : TextAlign.start,
                          'Flutter Developer',
                          textStyle: const TextStyle(
                            fontSize: 25,
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
              );

              Widget imageContent = RepaintBoundary(
                child: Container(
                  height: useVertical ? 200 : 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.1),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/Images/my_portfolio_pic.png',
                    fit: BoxFit.contain,
                  ),
                ),
              );

              if (useVertical) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      imageContent,
                      const SizedBox(height: 30),
                      textContent,
                    ],
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 3, child: textContent),
                    Expanded(flex: 2, child: imageContent),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
