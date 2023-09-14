import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../di/di.dart';
import '../../entities/spell_entity.dart';

class AllSpellsViewController extends ChangeNotifier {
  AllSpellsViewController(this.showErrorMessage) {
    _init();
  }

  Function(String) showErrorMessage;

  List<SpellEntity> _spells = [];
  List<SpellEntity> get spells => _spells;

  List<String> _availableButtons = ['levels', 'classes', 'schools'];
  List<String> get availableButtons => _availableButtons;

  final SpellsDataSource _spellsDataSource =
      Injector.resolve<SpellsDataSource>();

  Future<void> _init() async {
    try {
      await getSpells();
    } catch (e) {
      showErrorMessage('Error');
    }
  }

  Future<void> getSpells() async {
    final newSpells = await _spellsDataSource.getSpells();
    _spells = newSpells;
    notifyListeners();
  }

  void onLevelsChipClicked() {}

  void onClassesChipClicked() {}

  void onShoolsChipClicked() {}
}
