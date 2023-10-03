import 'dart:convert';

import 'package:adventurers_parchment/data_sources/spells/spells_data_source.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:flutter/services.dart';

const assetPath = 'assets/spells.json';

class SpellsLocalDataSource implements SpellsDataSource {
  @override
  Future<SpellEntityWithDetails> getDetailsForSpellByIndex(
      {required String spellIndex}) async {
    final spells = await getSpellsWithDetails();
    return spells.firstWhere((spell) => spell.index == spellIndex);
  }

  @override
  Future<List<SpellEntityWithDetails>> getSpellsWithDetails() async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> json = await jsonDecode(jsonString);
    final spells = json
        .map((spellJson) => SpellEntityWithDetails.fromJson(spellJson))
        .toList();
    return spells;
  }
}
