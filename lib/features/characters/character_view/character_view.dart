import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:adventurers_parchment/features/characters/blocs/character_cubit/character_cubit.dart';
import 'package:adventurers_parchment/features/characters/character_view/character_view_cubit.dart';
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
        final nullableCharacter = state.character;
        if (nullableCharacter == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final CharacterEntity character = nullableCharacter;
          return BlocProvider<CharacterViewCubit>(
            create: (context) => CharacterViewCubit(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<CharacterViewCubit, CharacterViewState>(
                builder: (context, state) {
                  final cubit = context.read<CharacterViewCubit>();
                  switch (state) {
                    case CharacterViewState.display:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CharacterNameWidget(character: character),
                          if (character.characterClasses.isNotEmpty) ...[
                            ListOfCharacterClassesWidget(character: character),
                          ],
                          Row(
                            children: [
                              const Text(
                                'Spells',
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => cubit.requestEdit(),
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: ListOfCharacterSpellsWidget(
                              character: character,
                            ),
                          ),
                        ],
                      );
                    case CharacterViewState.edit:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            character.name,
                            textAlign: TextAlign.center,
                          ),
                          if (character.characterClasses.isNotEmpty) ...[
                            Text(
                              character.characterClasses
                                  .map((characterClass) => characterClass.name)
                                  .join(', '),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                          Row(
                            children: [
                              const Text(
                                'Spells',
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => cubit.requestSave(),
                                icon: const Icon(Icons.check),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: ListOfCharacterSpellsWidget(
                              character: character,
                              isEditing: true,
                            ),
                          ),
                        ],
                      );
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}

class CharacterNameWidget extends StatelessWidget {
  const CharacterNameWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.name,
      textAlign: TextAlign.center,
    );
  }
}

class ListOfCharacterClassesWidget extends StatelessWidget {
  const ListOfCharacterClassesWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.characterClasses
          .map((characterClass) => characterClass.name)
          .join(', '),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
