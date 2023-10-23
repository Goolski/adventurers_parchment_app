import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:adventurers_parchment/features/characters/character_provider_widget/character_provider_widget.dart';
import 'package:adventurers_parchment/features/characters/characters_provider_widget/characters_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../blocs/character_cubit/character_cubit.dart';
import 'add_spell_to_characters_widget_cubit.dart';

class AddSpellToCharactersWidget extends StatelessWidget {
  final String spellId;
  const AddSpellToCharactersWidget({
    super.key,
    required this.spellId,
  });

  @override
  Widget build(BuildContext context) {
    return CharactersProviderWidget(
      builder: (characters) {
        if (characters.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return BlocProvider<AddSpellToCharactersWidgetCubit>(
            create: (context) =>
                Injector.resolve<AddSpellToCharactersWidgetCubit>(),
            child: BlocBuilder<AddSpellToCharactersWidgetCubit,
                AddSpellToCharactersWidgetState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case AddSpellToCharactersWidgetStateSaving:
                    final characterId =
                        (state as AddSpellToCharactersWidgetStateSaving)
                            .selectedCharacterId;
                    return CharacterProviderWidget(
                      characterId: characterId,
                      builder: (context, character) {
                        if (character != null) {
                          Future.delayed(
                            Duration(seconds: 2),
                            () => context
                                .read<CharacterCubit>()
                                .addSpell(spellId: spellId)
                                .then((value) => onSpellAdded(context)),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  case AddSpellToCharactersWidgetStateSelecting:
                  default:
                    return PopupMenuButton<CharacterEntity>(
                      icon: const Icon(Icons.add),
                      onSelected: (value) =>
                          onCharacterSelected(context, value.id),
                      itemBuilder: (context) => characters
                          .map(
                            (character) => PopupMenuItem(
                              value: character,
                              child: Text(character.name),
                            ),
                          )
                          .toList(),
                    );
                }
              },
            ),
          );
        }
      },
    );
  }

  onSpellAdded(BuildContext context) {
    context.read<AddSpellToCharactersWidgetCubit>().onSpellAdded();
  }

  onCharacterSelected(BuildContext context, String characterId) {
    context
        .read<AddSpellToCharactersWidgetCubit>()
        .onCharacterSelected(characterId);
  }
}
