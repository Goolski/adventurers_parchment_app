import 'package:adventurers_parchment/entities/spell_entity.dart';

abstract class SpellsDataSource {
  Future<List<SpellEntityWithDetails>> getSpellsWithDetails();
  Future<SpellEntityWithDetails> getDetailsForSpellByIndex(
      {required String spellIndex});
}
