import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'character_view_cubit.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterViewCubit, CharacterViewState>(
      builder: (context, state) {
        final character = state.character;
        if (character == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Text(character.name),
              Wrap(
                children: character.characterClasses
                    .map(
                      (characterClass) => FilterChip(
                          label: Text(characterClass.name), onSelected: (_) {}),
                    )
                    .toList(),
              ),
              Column(
                children: character.spellIds.map((e) => Text(e)).toList(),
              )
            ],
          );
        }
      },
    );
  }
}
