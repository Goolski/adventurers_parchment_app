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
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return SpellProviderWidget(
      spellIds: character.spellIds,
      builder: (spells) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: spells
            .map(
              (spell) => ListTile(
                title: Text(spell.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDeleteSpellPressed(
                    context: context,
                    spellId: spell.index,
                  ),
                ),
                onTap: () => context.go(
                  '/character/${character.id}/spell/${spell.index}',
                ),
              ),
            )
            .toList(),
      ),
      spellsDataSource: Injector.resolve<SpellsDataSource>(),
    );
  }

  onDeleteSpellPressed({
    required BuildContext context,
    required String spellId,
  }) {
    context.read<CharacterCubit>().removeSpell(spellId);
  }
}
