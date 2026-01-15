import 'package:fazal_portfolio/presentation/widgets/neumorphism_widget.dart';
import 'package:flutter/material.dart';

import 'hover_effect.dart';

class appBar extends StatelessWidget {
  const appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphism(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                HoverEffect(
                  child: Neumorphism(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                HoverEffect(
                  child: Neumorphism(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        'About',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                HoverEffect(
                  child: Neumorphism(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        'Skills',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                HoverEffect(
                  child: Neumorphism(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        'Contact',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
