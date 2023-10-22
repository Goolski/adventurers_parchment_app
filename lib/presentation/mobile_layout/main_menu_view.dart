import 'package:adventurers_parchment/features/characters/characters_provider_widget/characters_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    final textButtonTextStyle = Theme.of(context).textTheme.titleLarge;
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
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
                  ListOfCharactersWidget(),
                  TextButton(
                    onPressed: () => context.go('/create_character'),
                    child: Text(
                      'Create Character',
                      style: textButtonTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/spells'),
                    child: Text(
                      'All the spells I know?',
                      style: textButtonTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/spells/favorite'),
                    child: Text(
                      'Your favorite spells?',
                      style: textButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: TextButton(
            onPressed: () => context.go('/licenses'),
            child: Text(
              'Licenses',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class ListOfCharactersWidget extends StatelessWidget {
  const ListOfCharactersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CharactersProviderWidget(
      builder: (characters) => Column(
        children: characters
            .map(
              (character) => TextButton(
                onPressed: () => context.go('/character/${character.id}'),
                child: Text(character.name),
              ),
            )
            .toList(),
      ),
    );
  }
}
