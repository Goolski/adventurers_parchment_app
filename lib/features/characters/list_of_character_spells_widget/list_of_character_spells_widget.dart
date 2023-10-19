import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/features/characters/blocs/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data_sources/spells/spells_data_source.dart';
import '../../../di/di.dart';
import '../../../entities/character_entity.dart';
import '../../spells/spell_provider_widget/spell_provider_widget.dart';
import 'list_of_character_spells_widget_cubit.dart';

class ListOfCharacterSpellsWidget extends StatelessWidget {
  const ListOfCharacterSpellsWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListOfCharacterSpellsWidgetCubit>(
      create: (context) => ListOfCharacterSpellsWidgetCubit(),
      child: BlocBuilder<ListOfCharacterSpellsWidgetCubit,
          ListOfCharacterSpellsWidgetState>(
        builder: (context, state) {
          bool isEditing = state == ListOfCharacterSpellsWidgetState.edit;
          final cubit = context.read<ListOfCharacterSpellsWidgetCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    'Spells',
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  getIconButtonBasedOnState(cubit, state),
                ],
              ),
              SpellProviderWidget(
                spellIds: character.spellIds,
                builder: (spells) {
                  final mapOfSpellsByLevel = splitSpellsByLevel(spells);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: mapOfSpellsByLevel.keys
                        .map(
                          (level) => [
                            Text(
                              level.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            getWrappedSpells(
                                mapOfSpellsByLevel[level]!, isEditing, context),
                            SizedBox()
                          ],
                        )
                        .expand((element) => element)
                        .toList(),
                  );
                },
                spellsDataSource: Injector.resolve<SpellsDataSource>(),
              ),
            ],
          );
        },
      ),
    );
  }

  Wrap getWrappedSpells(List<SpellEntityWithDetails> spells, bool isEditing,
      BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: spells
          .map(
            (spell) => InputChip(
              label: Text(spell.name),
              onDeleted: isEditing
                  ? () => onDeleteSpellPressed(
                        context: context,
                        spellId: spell.index,
                      )
                  : null,
              onPressed: () => context.go(
                '/character/${character.id}/spell/${spell.index}',
              ),
            ),
          )
          .toList(),
    );
  }

  IconButton getIconButtonBasedOnState(
    ListOfCharacterSpellsWidgetCubit cubit,
    ListOfCharacterSpellsWidgetState state,
  ) {
    switch (state) {
      case ListOfCharacterSpellsWidgetState.display:
        return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => cubit.onEditPressed(),
        );
      case ListOfCharacterSpellsWidgetState.edit:
        return IconButton(
          icon: Icon(Icons.check),
          onPressed: () => cubit.onDonePressed(),
        );
    }
  }

  Map<int, List<SpellEntityWithDetails>> splitSpellsByLevel(
      List<SpellEntityWithDetails> spells) {
    var map = Map<int, List<SpellEntityWithDetails>>();
    var allLevels = spells.map((spell) => spell.level).toSet().toList();
    allLevels.sort();
    allLevels.forEach((level) {
      map[level] = [];
    });
    for (final spell in spells) {
      map[spell.level]!.add(spell);
    }
    return map;
  }

  onDeleteSpellPressed({
    required BuildContext context,
    required String spellId,
  }) {
    context.read<CharacterCubit>().removeSpell(spellId);
  }
}
