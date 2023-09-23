import 'package:dio/dio.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';

const apiPath = 'https://www.dnd5eapi.co';

class SpellsDataSource {
  final Dio _dio;

  SpellsDataSource(
    this._dio,
  );

  Future<List<SpellEntity>> getSpellsByLevel(
      {required Set<SpellLevel> levels}) async {
    final response =
        await _dio.get('$apiPath/api/spells?${levelsToUrl(levels)}');
    List<dynamic> results = response.data["results"];
    final spells =
        results.map((spellJson) => SpellEntity.fromJson(spellJson)).toList();
    return spells;
  }

  Future<List<SpellEntityWithDetails>> getDetailsForSpells(
      {List<SpellEntity>? spells}) async {
    spells ??= await getSpells();
    final spellsWithDetailsFutures =
        spells.map((spell) => getDetailsForSpell(spell: spell));
    final spellsWithDetails = Future.wait(spellsWithDetailsFutures);
    return spellsWithDetails;
  }

  String levelsToUrl(Set<SpellLevel> levels) {
    return '${levels.map((e) => 'level=${e.index}').join('&')}';
  }

  Future<List<SpellEntity>> getSpells() async {
    final response = await _dio.get(
      '$apiPath/api/spells',
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    List<dynamic> results = response.data["results"];
    final spells =
        results.map((spellJson) => SpellEntity.fromJson(spellJson)).toList();
    return spells;
  }

  Future<SpellEntity> getSpellById({required String index}) async {
    final spells = await getSpells();
    return spells.firstWhere(
      (spell) => spell.index == index,
    );
  }

  Future<SpellEntityWithDetails> getDetailsForSpellByIndex(
      {required String spellIndex}) async {
    final spell = await getSpellById(index: spellIndex);
    final spellDetails = getDetailsForSpell(spell: spell);
    return spellDetails;
  }

  Future<SpellEntityWithDetails> getDetailsForSpell(
      {required SpellEntity spell}) async {
    final response = await _dio.get(
      '$apiPath${spell.url}',
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    final spellEntityWithDetails =
        SpellEntityWithDetails.fromJson(response.data);
    return spellEntityWithDetails;
  }
}
