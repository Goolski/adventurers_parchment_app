import 'package:adventurers_parchment/features/characters/blocs/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../list_of_character_spells_widget/list_of_character_spells_widget.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        final character = state.character;
        if (character == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  character.name,
                ),
                if (character.characterClasses.isNotEmpty) ...[
                  Text('Classes:'),
                  Wrap(
                    children: character.characterClasses
                        .map(
                          (characterClass) => Chip(
                            label: Text(characterClass.name),
                          ),
                        )
                        .toList(),
                  ),
                ],
                SingleChildScrollView(
                  child: ListOfCharacterSpellsWidget(character: character),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
