import 'package:fazal_portfolio/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InfoCard(
      widget: Row(
        mainAxisAlignment: .spaceBetween,
crossAxisAlignment: .center,
        children: [
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              Text('H e l l o , I  a m'),
              Text(
                'FAZAL-E-HAQ',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text('UI/UX Designer & Flutter Developer'),
            ],
          ),
         Image(
             height: double.infinity,
             image: AssetImage('assets/Images/my_portfolio_pic.png'))
        ],
      ),
    );
  }
}
