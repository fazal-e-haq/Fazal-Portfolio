import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: .symmetric(horizontal: 36),
      child: Column(

         children: [
           SizedBox(height: size.height * 0.07),
           Row(
            mainAxisAlignment: .start,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    ' About Me ',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    'iojfioewjffiowjefeffffffffffaduuahwduiahuidhaduahduiwa\nfffffuahgduiawhduiawhduiahduiawhduiffffffffff\nffffffaiduhawuidhawuidhuiawhduiawhduiawhdf\nfffffffffffffffffiowjfiwe\n',
                    maxLines: 4,
                    textAlign: .start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'iojfioewjffiowjefeffffffffffaduuahwduiahuidhaduahduiwa\nfffffuahgduiawhduiawhduiahduiawhduiffffffffff\nffffffaiduhawuidhawuidhuiawhduiawhduiawhdf\nfffffffffffffffffiowjfiwe\n',
                    maxLines: 4,
                    textAlign: .start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'iojfioewjffiowjefeffffffffffaduuahwduiahuidhaduahduiwa\nfffffuahgduiawhduiawhduiahduiawhduiffffffffff\nffffffaiduhawuidhawuidhuiawhduiawhduiawhdf\nfffffffffffffffffiowjfiwe\n\n\n',
                    maxLines: 4,
                    textAlign: .start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'iojfioewjffiowjefeffffffffffaduuahwduiahuidhaduahduiwa\nfffffuahgduiawhduiawhduiahduiawhduiffffffffff\nffffffaiduhawuidhawuidhuiawhduiawhduiawhdf\nfffffffffffffffffiowjfiwe\n\n\n',
                    maxLines: 4,
                    textAlign: .start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
              Container(height: 300, width: 400),
            ],
          ),
        ],
      ),
    );
  }
}
