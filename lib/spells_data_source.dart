import 'package:dio/dio.dart';
import 'package:dnd_app/entities/spell_entity.dart';

const apiPath = 'https://www.dnd5eapi.co/api';

class SpellsDataSource {
  final _dio = Dio();

  Future<List<SpellEntity>> getSpells() async {
    final response = await _dio.get(
      '$apiPath/spells',
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    List<dynamic> results = response.data["results"];
    final spells =
        results.map((spellJson) => SpellEntity.fromJson(spellJson)).toList();
    return spells;
  }
}
