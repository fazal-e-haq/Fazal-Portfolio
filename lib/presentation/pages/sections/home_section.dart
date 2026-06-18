import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/core/services/resume_downloader.dart';
import 'package:fazal_portfolio/presentation/widgets/neomorphism_information_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/button_widget.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Layout Builder for separate all screens and give me good looking UI in every screen
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet and Desktop Screens
          return InfoCardForDesktopAndTablet(
            fontSizeOfName: constraints.maxWidth < 830 ? 36 : 56,
            fontSizeOfSkills: constraints.maxWidth < 830 ? 22 : 35,
            height: constraints.maxWidth < 1100
                ? constraints.maxHeight * 0.57
                : constraints.maxHeight * 0.75,
            width: constraints.maxWidth * 0.8,
            downloadResume: downloadResume,
          );
        } else {
          return InfoCardForMobile(
            height: constraints.maxHeight * 0.35,
            width: constraints.maxWidth * 0.9,
            heightOfImage: constraints.maxHeight * 0.55,
            topPositionOfInfoCard: constraints.maxHeight * 0.53,
            downloadResume: downloadResume,
          );
        }
      },
    );
  }
}

// Info card for Desktop and tablet
class InfoCardForDesktopAndTablet extends StatelessWidget {
  const InfoCardForDesktopAndTablet({
    super.key,
    required this.fontSizeOfName,
    required this.fontSizeOfSkills,
    required this.height,
    required this.width,
    this.downloadResume,
  });
  final double fontSizeOfName;
  final double fontSizeOfSkills;
  final double height;
  final double width;
  final Function()? downloadResume;

  @override
  Widget build(BuildContext context) {
    return NeomorphismInformationCard(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Widget for name and some other details
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                const Text('Hello i am ,'),
                // My  full name
                RepaintBoundary(
                  child: AnimatedTextKit(
                    key: ValueKey(fontSizeOfName),
                    isRepeatingAnimation: false,
                    stopPauseOnTap: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      ScrambleAnimatedText(
                        speed: const Duration(milliseconds: 300),
                        'FAZAL-E-HAQ',
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                          fontSize: fontSizeOfName,
                          wordSpacing: 4,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                // My skill in a short way
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
                        textStyle:   TextStyle(
                          letterSpacing: 5,
                          fontSize: fontSizeOfSkills,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        ),
                      ),
                      TyperAnimatedText(
                        textAlign: TextAlign.start,
                        'Flutter Developer',
                        textStyle: TextStyle(
                          fontSize: fontSizeOfSkills,
                          letterSpacing: 5,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                ButtonWidget(
                  onPressed: downloadResume,
                  icon: const Icon(Icons.arrow_downward),
                  text: const Text('My Resume'),
                ),
              ],
            ),
          ),

          // Right side: Profile image
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/Images/my_portfolio_pic.webp',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Info card for mobile
class InfoCardForMobile extends StatelessWidget {
  const InfoCardForMobile({
    super.key,
    required this.height,
    required this.width,
    required this.heightOfImage,
    required this.topPositionOfInfoCard,
    this.downloadResume,
  });
  final double height;
  final double width;
  final double topPositionOfInfoCard;
  final double heightOfImage;
  final Function()? downloadResume;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              // Profile Image
              Positioned(
                top: 10,

                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.black12,
                        Colors.transparent,
                      ],
                      stops: [0.6, 0.85, 1.0],
                    ).createShader(
                      Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    );
                  },
                  blendMode: .dstIn,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withValues(alpha: 0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/Images/my_portfolio_pic.webp',
                      height: heightOfImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: topPositionOfInfoCard,
                child: NeomorphismInformationCard(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    children: [
                      const Text('Hello i am'),
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
                              textStyle: TextStyle(
                                fontSize: 30,
                                wordSpacing: 4,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // My skill in a short way
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
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.blueAccent,
                              ),
                            ),
                            TyperAnimatedText(
                              textAlign: TextAlign.start,
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

                      const SizedBox(height: 30),
                      ButtonWidget(
                        onPressed: downloadResume,
                        icon: const Icon(Icons.arrow_downward),
                        text: const Text('My Resume'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
