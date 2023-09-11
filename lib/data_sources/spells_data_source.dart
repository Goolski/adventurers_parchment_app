import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dnd_app/entities/spell_entity.dart';

const apiPath = 'https://www.dnd5eapi.co';

class SpellsDataSource {
  final Dio _dio;

  SpellsDataSource()
      : _dio = Dio()
          ..interceptors.add(
            DioCacheInterceptor(
              options: CacheOptions(
                store: HiveCacheStore(null),
                policy: CachePolicy.request,
              ),
            ),
          );

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
