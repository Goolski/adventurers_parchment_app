import 'package:flutter/material.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final textButtonStyle = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Oh Hello!\n I am a Parchment',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            'What whould You like to See?',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'All the spells I know?',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Spells of a particular class?',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Spells of a particular school?',
                  style: textButtonStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Your favorite spells?',
                  style: textButtonStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
