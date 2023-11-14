import 'package:adventurers_parchment/data_sources/spells/spells_data_source.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:flutter/material.dart';

class SpellProviderWidget extends StatelessWidget {
  final SpellsDataSource spellsDataSource;
  final List<String> spellIds;
  final Widget Function(List<SpellEntityWithDetails> spells) builder;

  const SpellProviderWidget({
    required this.spellIds,
    required this.builder,
    required this.spellsDataSource,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SpellEntityWithDetails>>(
      future: getFuture(spellIds),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<SpellEntityWithDetails>> getFuture(List<String> spellIds) {
    final listOfFutures = spellIds.map(
      (id) => spellsDataSource.getDetailsForSpellByIndex(spellIndex: id),
    );

    return Future.wait(listOfFutures);
  }
}
