import 'package:kiwi/kiwi.dart';

import '../data_sources/favorite_spells_local_data_source.dart';

part 'di.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    _$Injector().configure();
  }

  @Register.factory(FavoriteSpellsLocalDataSource)
  void configure();

  static final resolve = container.resolve;
}
