import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final textButtonTextStyle = Theme.of(context).textTheme.bodyLarge;
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
            'What would You like to See?',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Column(
            children: [
              TextButton(
                onPressed: () => context.go('/spells'),
                child: Text(
                  'All the spells I know?',
                  style: textButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Spells of a particular class?',
                  style: textButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Your favorite spells?',
                  style: textButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Spells of a particular ?',
                  style: textButtonTextStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
