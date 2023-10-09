import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/spells_options_wrapper.dart';
import 'package:equatable/equatable.dart';

class AllSpellsMobileViewState extends Equatable {
  final SpellsOptionsWrapper allFilterOptions;
  final SpellsOptionsWrapper selectedFilters;
  final List<SpellEntityWithDetails> filteredSpells;

  AllSpellsMobileViewState(
      {required this.allFilterOptions,
      required this.selectedFilters,
      required this.filteredSpells});

  @override
  List<Object> get props => [allFilterOptions, selectedFilters, filteredSpells];
  AllSpellsMobileViewState copyWith({
    SpellsOptionsWrapper? allFilterOptions,
    SpellsOptionsWrapper? selectedFilters,
    List<SpellEntityWithDetails>? filteredSpells,
  }) {
    return AllSpellsMobileViewState(
      allFilterOptions: allFilterOptions ?? this.allFilterOptions,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      filteredSpells: filteredSpells ?? this.filteredSpells,
    );
  }
}
