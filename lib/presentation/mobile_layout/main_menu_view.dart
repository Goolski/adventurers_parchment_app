import 'package:flutter/material.dart';

import 'main_scaffold.dart';

void goTo(BuildContext context, String path) {
  context.findAncestorWidgetOfExactType<MainScaffold>()!.goTo(context, path);
}

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final textButtonTextStyle = Theme.of(context).textTheme.titleLarge;
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
                onPressed: () => goTo(context, '/spells'),
                child: Text(
                  'All the spells I know?',
                  style: textButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () => goTo(context, '/spells/favorite'),
                child: Text(
                  'Your favorite spells?',
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
