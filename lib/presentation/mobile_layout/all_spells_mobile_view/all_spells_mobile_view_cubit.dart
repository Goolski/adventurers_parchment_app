import 'package:adventurers_parchment/data_sources/spells/spells_data_source.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/spells_options_wrapper.dart';
import 'package:bloc/bloc.dart';

import 'all_spells_mobile_view_state.dart';

class AllSpellsMobileViewCubit extends Cubit<AllSpellsMobileViewState> {
  AllSpellsMobileViewCubit(
    this._spellsDataSource,
  ) : super(AllSpellsMobileViewState(
          selectedFilters: SpellsOptionsWrapper.empty(),
          allFilterOptions: SpellsOptionsWrapper.empty(),
          filteredSpells: const [],
        )) {
    _init();
  }

  final SpellsDataSource _spellsDataSource;
  late final List<SpellEntityWithDetails> _allSpells;

  updateSelectedRanges(List<String> selectedRanges) {
    var currentFilters = state.selectedFilters;
    var newFilters = currentFilters.copyWith(ranges: selectedRanges);
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateSelectedDurations(List<String> selectedDurations) {
    var currentFilters = state.selectedFilters;
    var newFilters = currentFilters.copyWith(durations: selectedDurations);
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateSelectedCastingTimes(List<String> selectedCastingTimes) {
    var currentFilters = state.selectedFilters;
    var newFilters =
        currentFilters.copyWith(castingTimes: selectedCastingTimes);
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateSelectedLevels(List<int> selectedLevels) {
    var currentFilters = state.selectedFilters;
    var newFilters = currentFilters.copyWith(levels: selectedLevels);
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateSelectedSchools(List<String> selectedSchoolsNames) {
    var currentFilters = state.selectedFilters;
    final schoolsWithGivenNames = state.allFilterOptions.schools
        .where((school) => selectedSchoolsNames.contains(school.name))
        .toList();
    var newFilters = currentFilters.copyWith(schools: schoolsWithGivenNames);
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateRequiresConcentration({required bool? requiresConcentration}) {
    var currentFilters = state.selectedFilters;
    var newFilters = currentFilters.copyWith(
      concentration: () => requiresConcentration,
    );
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  void filterSpells() {
    var newSpells = _allSpells;
    if (state.selectedFilters.ranges.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) => state.selectedFilters.ranges.contains(spell.range),
          )
          .toList();
    }
    if (state.selectedFilters.levels.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) => state.selectedFilters.levels.contains(spell.level),
          )
          .toList();
    }
    if (state.selectedFilters.schools.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) => state.selectedFilters.schools.contains(spell.school),
          )
          .toList();
    }
    if (state.selectedFilters.durations.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) => state.selectedFilters.durations.contains(spell.duration),
          )
          .toList();
    }
    if (state.selectedFilters.castingTimes.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) =>
                state.selectedFilters.castingTimes.contains(spell.castingTime),
          )
          .toList();
    }
    if (state.selectedFilters.concentration != null) {
      newSpells = newSpells
          .where(
            (spell) =>
                spell.concentration == state.selectedFilters.concentration,
          )
          .toList();
    }
    emit(state.copyWith(filteredSpells: newSpells));
  }

  _init() async {
    _allSpells = await _spellsDataSource.getSpellsWithDetails();

    final options = SpellsOptionsWrapper.fromListOfSpells(spells: _allSpells);

    emit(
      AllSpellsMobileViewState(
        selectedFilters: SpellsOptionsWrapper.empty(),
        allFilterOptions: options,
        filteredSpells: _allSpells,
      ),
    );
  }
}
