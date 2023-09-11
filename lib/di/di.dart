import 'package:dnd_app/data_sources/spells_data_source.dart';
import 'package:kiwi/kiwi.dart';

part 'di.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    _$Injector().configure();
  }

  @Register.factory(SpellsDataSource)
  void configure();

  static final resolve = container.resolve;
}
