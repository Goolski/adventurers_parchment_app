import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/spell_entity.dart';

const favoriteSpellsBox = 'favorite-spells';
const favoriteSpellsKey = 'fav-spells';

class FavoriteSpellsLocalDataSource {
  Future<void> addFavouriteSpell({required SpellEntity spell}) async {
    var spellSet = await _getFavoriteSpells();
    spellSet.add(spell);

    await _updateFavoriteSpells(updatedSpells: spellSet);
  }

  Future<void> deleteFavoriteSpell({required SpellEntity spell}) async {
    var spellSet = await _getFavoriteSpells();
    spellSet.removeWhere((element) => element.index == spell.index);

    await _updateFavoriteSpells(updatedSpells: spellSet);
  }

  Future<Stream<Set<SpellEntity>>> getAllFavoriteSpellsStream() async {
    final box = await Hive.openBox(favoriteSpellsBox);

    final currentSpells = await _getFavoriteSpells();
    final BehaviorSubject<Set<SpellEntity>> behaviorSubject =
        BehaviorSubject.seeded(currentSpells);

    final streamSub = box
        .watch(key: favoriteSpellsKey)
        .asyncMap(
          (event) => _decodeSpells(event.value),
        )
        .doOnData((event) {
      behaviorSubject.add(event);
    }).listen((event) {});

    behaviorSubject.doOnCancel(() => streamSub.cancel());
    return behaviorSubject.stream;
  }

  Future<Stream<SpellEntity?>> getSingleFavouriteSpellStream(
      {required SpellEntity spell}) async {
    final box = await Hive.openBox(favoriteSpellsBox);

    final currentValue = await _getFavoriteSpell(spell: spell);
    BehaviorSubject<SpellEntity?> behaviorSubject =
        BehaviorSubject.seeded(currentValue);

    final allSpellStream = box.watch(key: favoriteSpellsKey).asyncMap(
          (event) => _decodeSpells(event.value),
        );
    final stream = allSpellStream.asyncMap((setOfSpells) {
      return setOfSpells
          .firstWhereOrNull((element) => element.index == spell.index);
    }).doOnData((event) {
      behaviorSubject.add(event);
    });
    final streamSub = stream.listen((event) {});
    behaviorSubject.doOnCancel(() => streamSub.cancel());
    return behaviorSubject.stream;
  }

  Future<SpellEntity?> _getFavoriteSpell({required SpellEntity spell}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    final spells = _decodeSpells(box.get(favoriteSpellsKey));
    return spells.firstWhereOrNull((element) => element.index == spell.index);
  }

  Future<Set<SpellEntity>> _getFavoriteSpells() async {
    final box = await Hive.openBox(favoriteSpellsBox);
    final spellsJson = await box.get(favoriteSpellsKey);
    if (spellsJson == null) {
      _initiateFavoriteSpells();
      return <SpellEntity>{};
    }
    final spells = _decodeSpells(spellsJson);
    return spells;
  }

  Future<void> _updateFavoriteSpells(
      {required Set<SpellEntity> updatedSpells}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    await box.put(favoriteSpellsKey, _encodeSpellsIntoJson(updatedSpells));
  }

  Set<SpellEntity> _decodeSpells(String json) {
    final List<dynamic> jsonList = jsonDecode(json);
    return jsonList
        .map(
          (json) => SpellEntity.fromJson(json),
        )
        .toSet();
  }

  String _encodeSpellsIntoJson(Set<SpellEntity> spells) {
    return jsonEncode(spells.toList());
  }

  Future<void> _initiateFavoriteSpells() async {
    final box = await Hive.openBox(favoriteSpellsBox);
    await box.put(favoriteSpellsKey, jsonEncode([]));
  }
}
