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
    required this.components,
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
      components: [],
      concentration: null,
      ritual: null,
    );
  }

  factory SpellsOptionsWrapper.defaultOptions(
      {required List<SpellEntityWithDetails> spells}) {
    return SpellsOptionsWrapper(
      levels: const [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      castingTimes: _getAllCastingTimes(),
      ranges: _getAllRanges(),
      schools: _getAllOptionsForSchoolFromSpells(spells),
      durations: _getAllDurations(),
      components: _getAllSpellComponents(),
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
      components: _getAllSpellComponents(),
      concentration: null,
      ritual: null,
    );
  }

  final List<int> levels;
  final List<String> castingTimes;
  final List<String> ranges;
  final List<SchoolEntity> schools;
  final List<String> durations;
  final List<SpellComponent> components;
  final bool? concentration;
  final bool? ritual;

  @override
  List<Object?> get props => [
        levels,
        castingTimes,
        ranges,
        schools,
        durations,
        concentration,
        ritual,
        components,
      ];
  SpellsOptionsWrapper copyWith({
    List<int>? levels,
    List<String>? castingTimes,
    List<String>? ranges,
    List<SchoolEntity>? schools,
    List<SpellComponent>? components,
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
      components: components ?? this.components,
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

  static List<SpellComponent> _getAllSpellComponents() {
    return [
      SpellComponent.verbal,
      SpellComponent.somatic,
      SpellComponent.material
    ];
  }

  static List<String> _getAllCastingTimes() {
    return [
      '1 action',
      '1 minute',
      '1 hour',
      '8 hours',
      '1 bonus action',
      '10 minutes',
      '1 reaction',
      '24 hours',
      '12 hours',
    ];
  }

  static List<String> _getAllDurations() {
    return [
      'Instantaneous',
      '1 round',
      'Up to 1 round',
      'Up to 1 minute',
      '1 minute',
      'Up to 10 minutes',
      '10 minutes',
      '1 hour',
      'Up to 1 hour',
      'Up to 2 hours',
      '8 hours',
      'Up to 8 hours',
      'Up to 24 hours',
      '24 hours',
      '7 days',
      '10 days',
      '30 days',
      'Until dispelled',
      'Special',
    ];
  }

  static List<String> _getAllRanges() {
    return [
      'Self',
      'Touch',
      'Sight',
      '5 feet',
      '10 feet',
      '30 feet',
      '60 feet',
      '90 feet',
      '100 feet',
      '120 feet',
      '150 feet',
      '300 feet',
      '500 feet',
      '1 mile',
      '500 miles',
      'Unlimited',
      'Special',
    ];
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
