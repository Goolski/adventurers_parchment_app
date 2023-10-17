import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/spells_options_wrapper.dart';
import 'package:equatable/equatable.dart';

import '../../DTOs/selectable_DTO.dart';

class AllSpellsMobileViewState extends Equatable {
  final List<SelectableDTO> availableFilters;
  final SpellsOptionsWrapper allFilterOptions;
  final SpellsOptionsWrapper selectedFilters;
  final List<SpellEntityWithDetails> filteredSpells;
  final String searchString;

  AllSpellsMobileViewState({
    required this.searchString,
    required this.availableFilters,
    required this.allFilterOptions,
    required this.selectedFilters,
    required this.filteredSpells,
  });

  @override
  List<Object> get props => [
        allFilterOptions,
        selectedFilters,
        filteredSpells,
        availableFilters,
        searchString
      ];
  AllSpellsMobileViewState copyWith({
    String? searchString,
    SpellsOptionsWrapper? allFilterOptions,
    SpellsOptionsWrapper? selectedFilters,
    List<SpellEntityWithDetails>? filteredSpells,
    List<SelectableDTO>? availableFilters,
  }) {
    return AllSpellsMobileViewState(
      searchString: searchString ?? this.searchString,
      availableFilters: availableFilters ?? this.availableFilters,
      allFilterOptions: allFilterOptions ?? this.allFilterOptions,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      filteredSpells: filteredSpells ?? this.filteredSpells,
    );
  }
}
