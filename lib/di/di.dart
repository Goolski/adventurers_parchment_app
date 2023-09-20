import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:dnd_app/data_sources/spells_data_source.dart';
import 'package:kiwi/kiwi.dart';

part 'di.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    _$Injector().configure();
  }

  void configure() {
    configureDio();
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

  @Register.factory(SpellsDataSource)
  void configureGenerated();

  static final resolve = container.resolve;
}
