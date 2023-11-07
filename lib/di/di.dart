import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/data_sources/spells/spells_data_source.dart';
import 'package:adventurers_parchment/data_sources/spells/spells_local_data_source.dart';
import 'package:adventurers_parchment/features/characters/add_spell_to_characters_widget/add_spell_to_characters_widget_cubit.dart';
import 'package:adventurers_parchment/features/characters/blocs/characters_cubit/characters_cubit.dart';
import 'package:adventurers_parchment/features/characters/create_character_view/create_character_cubit.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:kiwi/kiwi.dart';

import '../data_sources/database.dart';
import '../entities/character_entity.dart';

part 'di.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    _$Injector().configure();
  }

  void configure() {
    configureDio();
    configureCharacterEntityDatabase();
    configureGenerated();
  }

  void configureDio() {
    configureDioInterceptors();
    container.registerFactory((container) {
      final Dio dio = Dio();
      dio.interceptors.add(container.resolve<DioCacheInterceptor>());
      dio.interceptors.add(
        RetryInterceptor(
          dio: dio,
        ),
      );
      return dio;
    });
  }

  void configureDioInterceptors() {
    container.registerFactory(
      (container) => DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(null),
          policy: CachePolicy.forceCache,
        ),
      ),
    );
  }

  void configureCharacterEntityDatabase() {
    container.registerInstance<Database<CharacterEntity>>(
      Database<CharacterEntity>(),
    );
  }

  @Register.factory(CharactersCubit)
  @Register.factory(AddSpellToCharactersWidgetCubit)
  @Register.factory(CreateCharacterCubit)
  @Register.factory(CharactersLocalDataSource)
  @Register.factory(SpellsDataSource, from: SpellsLocalDataSource)
  void configureGenerated();

  static final resolve = container.resolve;
}
