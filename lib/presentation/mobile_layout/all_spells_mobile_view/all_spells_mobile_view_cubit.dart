import 'package:adventurers_parchment/data_sources/spells/spells_data_source.dart';
import 'package:adventurers_parchment/entities/character_class_entity.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/presentation/DTOs/selectable_DTO.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/spells_options_wrapper.dart';
import 'package:bloc/bloc.dart';

import 'all_spells_mobile_view_state.dart';

const allFilterStrings = [
  'Search',
  'Range',
  'Duration',
  'Classes',
  'Casting Time',
  'Level',
  'School',
  'Components',
];

class AllSpellsMobileViewCubit extends Cubit<AllSpellsMobileViewState> {
  AllSpellsMobileViewCubit(
    this._spellsDataSource,
  ) : super(
          AllSpellsMobileViewState(
            searchString: '',
            selectedFilters: SpellsOptionsWrapper.empty(),
            allFilterOptions: SpellsOptionsWrapper.empty(),
            filteredSpells: const [],
            availableFilters: allFilterStrings
                .map(
                    (option) => SelectableDTO(thing: option, isSelected: false))
                .toList(),
          ),
        ) {
    _init();
  }

  final SpellsDataSource _spellsDataSource;
  late final List<SpellEntityWithDetails> _allSpells;

  selectFilter(SelectableDTO filter) {
    final indexOfFilter = state.availableFilters.indexOf(filter);
    SelectableDTO newFilterState = filter.copyWith(
      isSelected: !filter.isSelected,
    );
    final newAvailableFilters = List<SelectableDTO>.from(state.availableFilters)
      ..replaceRange(indexOfFilter, indexOfFilter + 1, [newFilterState]);
    final newState = state.copyWith(availableFilters: newAvailableFilters);
    emit(newState);
  }

  onSearchStringChanged(String searchString) {
    emit(state.copyWith(searchString: searchString));
    filterSpells();
  }

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

  updateSelectedCharacterClasses(List<String> selectedCharacterClasses) {
    var currentFilters = state.selectedFilters;
    var selectedCharacterClassesEntities = List<CharacterClassEntity>.from(
      state.allFilterOptions.characterClasses
          .where(
            (element) => selectedCharacterClasses.contains(element.name),
          )
          .toList(),
    );
    var newFilters = currentFilters.copyWith(
        characterClasses: selectedCharacterClassesEntities);
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

  updateSelectedComponents({required List<String> spellComponentsNames}) {
    var currentFilters = state.selectedFilters;
    var spellComponents = state.allFilterOptions.components
        .where(
          (component) => spellComponentsNames.contains(
            component.getString(),
          ),
        )
        .toList();
    var newFilters = currentFilters.copyWith(
      components: spellComponents,
    );
    var newState = state.copyWith(selectedFilters: newFilters);
    emit(newState);
    filterSpells();
  }

  updateIsRitual({required bool? isRitual}) {
    var currentFilters = state.selectedFilters;
    var newFilters = currentFilters.copyWith(
      ritual: () => isRitual,
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
    if (state.selectedFilters.components.isNotEmpty) {
      newSpells = newSpells
          .where((spell) =>
              spell.components.containsAll(state.selectedFilters.components))
          .toList();
    }
    if (state.selectedFilters.characterClasses.isNotEmpty) {
      newSpells = newSpells
          .where(
            (spell) => state.selectedFilters.characterClasses.any(
              (selectedClass) => spell.characterClasses.contains(selectedClass),
            ),
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
    if (state.selectedFilters.ritual != null) {
      newSpells = newSpells
          .where(
            (spell) => spell.ritual == state.selectedFilters.ritual,
          )
          .toList();
    }
    if (state.searchString.isNotEmpty) {
      newSpells = newSpells
          .where((spell) => spell.name
              .toLowerCase()
              .contains(state.searchString.toLowerCase()))
          .toList();
    }
    emit(state.copyWith(filteredSpells: newSpells));
  }

  _init() async {
    _allSpells = await _spellsDataSource.getSpellsWithDetails();

    final options = SpellsOptionsWrapper.defaultOptions(spells: _allSpells);

    emit(
      AllSpellsMobileViewState(
        searchString: state.searchString,
        availableFilters: state.availableFilters,
        selectedFilters: SpellsOptionsWrapper.empty(),
        allFilterOptions: options,
        filteredSpells: _allSpells,
      ),
    );
  }

  void resetFilters() {
    emit(
      AllSpellsMobileViewState(
        searchString: '',
        availableFilters: allFilterStrings
            .map((option) => SelectableDTO(thing: option, isSelected: false))
            .toList(),
        selectedFilters: SpellsOptionsWrapper.empty(),
        allFilterOptions:
            SpellsOptionsWrapper.defaultOptions(spells: _allSpells),
        filteredSpells: _allSpells,
      ),
    );
  }
}
