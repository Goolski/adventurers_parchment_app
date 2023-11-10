import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/features/characters/blocs/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data_sources/spells/spells_data_source.dart';
import '../../../di/di.dart';
import '../../../entities/character_entity.dart';
import '../../spells/spell_provider_widget/spell_provider_widget.dart';

class ListOfCharacterSpellsWidget extends StatelessWidget {
  const ListOfCharacterSpellsWidget({
    super.key,
    required this.character,
    this.isEditing = false,
  });

  final CharacterEntity character;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SpellProviderWidget(
          spellIds: character.spellIds,
          builder: (spells) {
            final mapOfSpellsByLevel =
                SpellEntityWithDetails.splitSpellsByLevel(spells);
            final levels = mapOfSpellsByLevel.keys;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: levels.map(
                (level) {
                  //Null check is required for Maps
                  final spellsOfCurrentLevel = mapOfSpellsByLevel[level]!;
                  return SpellsGroupedBySomethingWidget(
                    something: level.toString(),
                    spells: spellsOfCurrentLevel,
                    isEditing: isEditing,
                    onDeletePressed: (spellId) =>
                        onSpellDelete(context: context, spellId: spellId),
                    onSpellPressed: (spellId) =>
                        onSpellPressed(context: context, spellId: spellId),
                  );
                },
              ).toList(),
            );
          },
          spellsDataSource: Injector.resolve<SpellsDataSource>(),
        ),
      ],
    );
  }

  onSpellDelete({
    required BuildContext context,
    required String spellId,
  }) {
    context.read<CharacterCubit>().removeSpell(spellId);
  }

  onSpellPressed({
    required BuildContext context,
    required String spellId,
  }) {
    context.go(
      '/character/${character.id}/spell/${spellId}',
    );
  }
}

class SpellsGroupedBySomethingWidget extends StatelessWidget {
  const SpellsGroupedBySomethingWidget({
    super.key,
    required this.something,
    required this.spells,
    required this.isEditing,
    required this.onDeletePressed,
    required this.onSpellPressed,
  });

  final List<SpellEntityWithDetails> spells;
  final String something;
  final bool isEditing;
  final Function(String spellId) onDeletePressed;
  final Function(String spellId) onSpellPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          something,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: spells
                .map(
                  (spell) => InputChip(
                    label: Text(spell.name),
                    onDeleted:
                        isEditing ? () => onDeletePressed(spell.index) : null,
                    onPressed: () => onSpellPressed(
                      spell.index,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
