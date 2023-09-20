import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../di/di.dart';
import '../../entities/spell_entity.dart';

class AllSpellsViewController extends ChangeNotifier {
  AllSpellsViewController(this.showErrorMessage) {
    _init();
  }

  Function(String) showErrorMessage;

  bool _spellsLoaded = false;

  get spellsLoaded => _spellsLoaded;

  late final List<SpellEntityWithDetails> _allSpells;
  List<SpellEntity> _displayedSpells = [];
  List<SpellEntity> get spells => _displayedSpells;

  List<String> _availableButtons = ['levels', 'classes', 'schools'];
  List<String> get availableButtons => _availableButtons;

  late final List<String> availableLevels;
  late final List<String> availableSchools;
  late final List<String> availableClasses;

  List<String> _selectedLevels = [];
  List<String> _selectedSchools = [];
  List<String> _selectedClasses = [];

  List<String> get selectedLevels => _selectedLevels;
  List<String> get selectedSchools => _selectedSchools;
  List<String> get selectedClasses => _selectedClasses;

  final SpellsDataSource _spellsDataSource =
      Injector.resolve<SpellsDataSource>();

  void onChipClicked(int index) {
    switch (index) {
      case 0:
        _onLevelsChipClicked();
      case 1:
        _onClassesChipClicked();
      case 2:
        _onShoolsChipClicked();
    }
  }

  void _onLevelsChipClicked() {
    _availableButtons.remove('levels');
    notifyListeners();
  }

  void _onClassesChipClicked() {
    _availableButtons.remove('classes');
    notifyListeners();
  }

  void _onShoolsChipClicked() {
    _availableButtons.remove('schools');
    notifyListeners();
  }

  void onLevelClicked(int index) {
    if (_selectedLevels.contains(availableLevels[index])) {
      _selectedLevels.remove(availableLevels[index]);
    } else {
      _selectedLevels.add(availableLevels[index]);
    }
    _filterSpells();
    notifyListeners();
  }

  void onClassClicked(int index) {
    if (_selectedClasses.contains(availableClasses[index])) {
      _selectedClasses.remove(availableClasses[index]);
    } else {
      _selectedClasses.add(availableClasses[index]);
    }
    _filterSpells();
    notifyListeners();
  }

  void onSchoolClicked(int index) {
    if (_selectedSchools.contains(availableSchools[index])) {
      _selectedSchools.remove(availableSchools[index]);
    } else {
      _selectedSchools.add(availableSchools[index]);
    }
    _filterSpells();
    notifyListeners();
  }

  Future<void> _init() async {
    try {
      await _getSpells();
    } on DioException catch (e) {
      if (e.error is SocketException)
        showErrorMessage(
          "Cannot connect to Guild of Magic. Are you sure you have internet connection?",
        );
    } catch (e) {
      showErrorMessage("Unknown error. Please try again later");
    }
  }

  Future<void> _getSpells() async {
    final List<SpellEntityWithDetails> newSpells =
        await _spellsDataSource.getDetailsForSpells();

    _allSpells = newSpells;
    _displayedSpells = newSpells;

    availableLevels = newSpells
        .map((spell) => spell.level)
        .toSet()
        .sorted((a, b) => a - b)
        .map((e) => e.toString())
        .toList();
    availableSchools =
        newSpells.map((spell) => spell.school.name).toSet().toList();
    availableClasses = newSpells
        .expand(
          (spell) => spell.characterClasses.map((e) => e.name),
        )
        .toSet()
        .toList();

    _spellsLoaded = true;
    notifyListeners();
  }

  void _filterSpells() {
    List<SpellEntityWithDetails> spells = _allSpells;
    if (selectedLevels.isNotEmpty) spells = _filterByLevel(spells);
    if (selectedClasses.isNotEmpty) spells = _filterByClass(spells);
    if (selectedSchools.isNotEmpty) spells = _filterBySchool(spells);
    _displayedSpells = spells;
  }

  List<SpellEntityWithDetails> _filterByLevel(
      List<SpellEntityWithDetails> spells) {
    return spells
        .where((spell) => selectedLevels.contains(spell.level.toString()))
        .toList();
  }

  List<SpellEntityWithDetails> _filterByClass(
      List<SpellEntityWithDetails> spells) {
    return spells
        .where(
          (spell) => spell.characterClasses.any(
            (charClass) => selectedClasses.contains(charClass.name),
          ),
        )
        .toList();
  }

  List<SpellEntityWithDetails> _filterBySchool(
      List<SpellEntityWithDetails> spells) {
    return spells
        .where(
          (spell) => selectedSchools.contains(spell.school.name),
        )
        .toList();
  }
}
