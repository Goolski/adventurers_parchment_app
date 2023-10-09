import 'package:adventurers_parchment/entities/school_entity.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../../common/filtering/filtering_helpers.dart';
import '../../../entities/spell_entity.dart';

class SpellsOptionsWrapper extends Equatable {
  const SpellsOptionsWrapper({
    required this.levels,
    required this.castingTimes,
    required this.ranges,
    required this.schools,
    required this.durations,
    required this.concentration,
    required this.ritual,
  });

  factory SpellsOptionsWrapper.empty() {
    return const SpellsOptionsWrapper(
      levels: [],
      castingTimes: [],
      ranges: [],
      schools: [],
      durations: [],
      concentration: null,
      ritual: null,
    );
  }

  factory SpellsOptionsWrapper.fromListOfSpells(
      {required List<SpellEntityWithDetails> spells}) {
    return SpellsOptionsWrapper(
      levels: _getAllOptionsForLevelFromSpells(spells),
      castingTimes: _getAllOptionsForCastingTimeFromSpells(spells),
      ranges: _getAllOptionsForRangeFromSpells(spells),
      schools: _getAllOptionsForSchoolFromSpells(spells),
      durations: _getAllOptionsForDurationFromSpells(spells),
      concentration: null,
      ritual: null,
    );
  }

  final List<int> levels;
  final List<String> castingTimes;
  final List<String> ranges;
  final List<SchoolEntity> schools;
  final List<String> durations;
  final bool? concentration;
  final bool? ritual;

  @override
  List<Object?> get props =>
      [levels, castingTimes, ranges, schools, durations, concentration, ritual];
  SpellsOptionsWrapper copyWith({
    List<int>? levels,
    List<String>? castingTimes,
    List<String>? ranges,
    List<SchoolEntity>? schools,
    List<String>? durations,
    bool? Function()? concentration,
    bool? Function()? ritual,
  }) {
    return SpellsOptionsWrapper(
      levels: levels ?? this.levels,
      castingTimes: castingTimes ?? this.castingTimes,
      ranges: ranges ?? this.ranges,
      schools: schools ?? this.schools,
      durations: durations ?? this.durations,
      concentration:
          concentration != null ? concentration() : this.concentration,
      ritual: ritual != null ? ritual() : this.ritual,
    );
  }

  static List<int> _getAllOptionsForLevelFromSpells(
      List<SpellEntityWithDetails> spells) {
    return getAllOptionsFrom(spells, (object) => object.level)
        .sorted((a, b) => a - b);
  }

  static List<SchoolEntity> _getAllOptionsForSchoolFromSpells(
      List<SpellEntityWithDetails> spells) {
    return getAllOptionsFrom<SpellEntityWithDetails, SchoolEntity>(
      spells,
      (spell) => spell.school,
    ).sorted(
      (a, b) => a.name.compareTo(b.name),
    );
  }

  static List<String> _getAllOptionsForDurationFromSpells(
      List<SpellEntityWithDetails> spells) {
    return getAllOptionsFrom<SpellEntityWithDetails, String>(
      spells,
      (spell) => spell.duration,
    );
  }

  static List<String> _getAllOptionsForCastingTimeFromSpells(
      List<SpellEntityWithDetails> spells) {
    return getAllOptionsFrom<SpellEntityWithDetails, String>(
      spells,
      (object) => object.castingTime,
    );
  }

  static List<String> _getAllOptionsForRangeFromSpells(
      List<SpellEntityWithDetails> spells) {
    return getAllOptionsFrom<SpellEntityWithDetails, String>(
      spells,
      (object) => object.range,
    );
  }
}
