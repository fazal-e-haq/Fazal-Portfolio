import 'package:fazal_portfolio/presentation/widgets/app_bar.dart';
import 'package:fazal_portfolio/presentation/widgets/hover_effect.dart';
import 'package:fazal_portfolio/presentation/widgets/neumorphism_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class ComputerHomePage extends StatefulWidget {
  const ComputerHomePage({super.key});

  @override
  State<ComputerHomePage> createState() => _ComputerHomePageState();
}

class _ComputerHomePageState extends State<ComputerHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: .symmetric(horizontal: 26),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: size.height * 0.02),
                appBar(),
                SizedBox(height: size.height * 0.1),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .end,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          ' H i,  i  a m ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        AnimatedTextKit(
                          repeatForever: false,
                          totalRepeatCount: 1,
                          animatedTexts: [
                            BounceAnimatedText(
                              'Fazal-e-Haq',
                              textAlign: .start,
                              curve: Curves.easeOut,
                              bounceHeight: 15,
                              duration: Duration(seconds: 1),
                              textStyle: GoogleFonts.poppins(
                                fontSize: 54,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                                // shadows: [
                                //   Shadow(
                                //     color: Colors.white.withValues(alpha: 0.9),
                                //     offset: Offset(-3, -3),
                                //     blurRadius: 6,
                                //   ),
                                //   Shadow(
                                //     color: Colors.grey.shade500,
                                //     offset: Offset(3, 3),
                                //     blurRadius: 6,
                                //   ),
                                // ],
                              ),
                            ),
                          ],
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          totalRepeatCount: 1,
                          pause: Duration(seconds: 3),
                          animatedTexts: [
                            TyperAnimatedText(
                              speed: Duration(milliseconds: 100),
                              textAlign: .start,
                              'Flutter Developer',
                              textStyle: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                                // shadows: [
                                //   Shadow(
                                //     color: Colors.white.withOpacity(0.9),
                                //     offset: Offset(-3, -3),
                                //     blurRadius: 6,
                                //   ),
                                //   Shadow(
                                //     color: Colors.grey.shade500,
                                //     offset: Offset(3, 3),
                                //     blurRadius: 6,
                                //   ),
                                // ],
                              ),
                            ),

                            TyperAnimatedText(
                              speed: Duration(milliseconds: 100),
                              textAlign: .start,
                              'UI/UX Designer',
                              textStyle: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                                // shadows: [
                                //   Shadow(
                                //     color: Colors.white.withOpacity(0.9),
                                //     offset: Offset(-3, -3),
                                //     blurRadius: 6,
                                //   ),
                                //   Shadow(
                                //     color: Colors.grey.shade500,
                                //     offset: Offset(3, 3),
                                //     blurRadius: 6,
                                //   ),
                                // ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Neumorphism(child: Container(height: 400, width: 700)),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  'I am a Flutter-focused software developer specializing in building modern,high-performance mobile and web interfaces.\n'
                  'I continuously refine my skills to deliver scalable, visually refined applications.',
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    Neumorphism(
                      borderRadius: 20,
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Icon(Icons.add_a_photo, size: 50,color: Colors.grey.shade500,),
                      ),
                    ),
                    SizedBox(width: 20),
                    Neumorphism(
                      borderRadius: 20,
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Icon(Icons.add_a_photo, size: 50,color: Colors.grey.shade500,),
                      ),
                    ),
                    SizedBox(width: 20),
                    Neumorphism(
                      borderRadius: 20,
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Icon(Icons.add_a_photo, size: 50,color: Colors.grey.shade500,),
                      ),
                    ),
                    SizedBox(width: 20),
                    Neumorphism(
                      borderRadius: 20,
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Icon(Icons.add_a_photo, size: 50,color: Colors.grey.shade500,),
                      ),
                    ),
                    SizedBox(width: 20),
                                    ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
