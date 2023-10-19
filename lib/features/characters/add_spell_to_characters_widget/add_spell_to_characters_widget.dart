import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:adventurers_parchment/features/characters/add_spell_to_characters_widget/add_spell_to_characters_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';

class AddSpellToCharactersWidget extends StatelessWidget {
  final String spellId;
  const AddSpellToCharactersWidget({
    super.key,
    required this.spellId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSpellToCharactersWidgetCubit>(
      create: (context) => Injector.resolve<AddSpellToCharactersWidgetCubit>(),
      child: BlocBuilder<AddSpellToCharactersWidgetCubit,
          AddSpellToCharactersWidgetState>(
        builder: (context, state) {
          if (state.characters.isEmpty) {
            return const SizedBox.shrink();
          }
          return PopupMenuButton<CharacterEntity>(
            icon: const Icon(Icons.add),
            onSelected: (selectedCharacter) => context
                .read<AddSpellToCharactersWidgetCubit>()
                .addSpellToCharacter(
                  character: selectedCharacter,
                  spellId: spellId,
                ),
            itemBuilder: (context) => state.characters
                .map(
                  (character) => PopupMenuItem(
                    value: character,
                    child: Text(character.name),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
