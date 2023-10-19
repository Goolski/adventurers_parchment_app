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
                builder: (spells) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: spells
                          .map(
                            (spell) => ListTile(
                              title: Text(spell.name),
                              trailing:
                                  getDeleteSpellButton(state, context, spell),
                              onTap: () => context.go(
                                '/character/${character.id}/spell/${spell.index}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                spellsDataSource: Injector.resolve<SpellsDataSource>(),
              ),
            ],
          );
        },
      ),
    );
  }

  IconButton? getDeleteSpellButton(ListOfCharacterSpellsWidgetState state,
      BuildContext context, SpellEntityWithDetails spell) {
    if (state == ListOfCharacterSpellsWidgetState.edit) {
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDeleteSpellPressed(
          context: context,
          spellId: spell.index,
        ),
      );
    } else {
      return null;
    }
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

  onDeleteSpellPressed({
    required BuildContext context,
    required String spellId,
  }) {
    context.read<CharacterCubit>().removeSpell(spellId);
  }
}
