import 'package:dio/dio.dart';
import 'package:dnd_app/entities/spell_entity.dart';

const apiPath = 'https://www.dnd5eapi.co';

class SpellsDataSource {
  final _dio = Dio();

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
