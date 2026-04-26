import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
          padding: .symmetric(),
          child: Center(
            child: InfoCardWidget(
              width: size.width * 0.76,
              height: size.height * 0.62,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Text('H e l l o'),
                      AnimatedTextKit(
                        isRepeatingAnimation: false,
                        stopPauseOnTap: false,
                        totalRepeatCount: 1,

                        animatedTexts: [
                          ScrambleAnimatedText(
                            speed: Duration(milliseconds: 300),
                            'Fazal-e-haq',
                            textAlign: .start,
                            textStyle: Theme.of(
                              context,
                            ).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.013),
                      AnimatedTextKit(
                        repeatForever: true,
                        stopPauseOnTap: false,
                        isRepeatingAnimation: true,
                        pause: Duration(seconds: 3),
                        animatedTexts: [
                          TyperAnimatedText(
                            textAlign: .start,
                            'UI/UX Designer',
                            textStyle: Theme.of(
                              context,
                            ).textTheme.headlineMedium,
                          ),
                          TyperAnimatedText(
                            textAlign: .start,
                            'Flutter Developer',
                            textStyle: Theme.of(
                              context,
                            ).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Image.asset('assets/Images/my_portfolio_pic.png'),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
