import 'dart:async';
import 'dart:convert';

import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

const charactersBox = 'characters';
const charactersKey = 'characters';

class CharacterExistsException implements Exception {
  final String message = 'Character with given id already Exists';
}

class CharactersLocalDataSource {
  Future<void> create({required CharacterEntity newCharacter}) async {
    final characters = await _getAllCharacters();
    if (characters
        .any((existingCharacter) => existingCharacter.id == newCharacter.id)) {
      throw CharacterExistsException();
    } else {
      final updatedCharacters = characters.union({newCharacter});
      await _updateCharacters(updatedCharacters: updatedCharacters);
    }
  }

  Stream<Set<String>> getAllIds() {
    final streamOfCharacterId = _getAllCharactersStream().asyncMap(
      (setOfCharacters) =>
          setOfCharacters.map((character) => character.id).toSet(),
    );

    return streamOfCharacterId;
  }

  Stream<CharacterEntity> readById({required String id}) {
    final streamForCharacter = _getAllCharactersStream().asyncMap(
      (setOfCharacters) =>
          setOfCharacters.firstWhere((character) => character.id == id),
    );

    return streamForCharacter;
  }

  Future<void> update({required CharacterEntity updatedCharacter}) async {
    var existingCharacters =
        Set<CharacterEntity>.from(await _getAllCharacters());
    existingCharacters.removeWhere(
        (existingCharacter) => existingCharacter.id == updatedCharacter.id);
    existingCharacters.add(updatedCharacter);
    await _updateCharacters(updatedCharacters: existingCharacters);
  }

  Future<void> delete({required CharacterEntity character}) async {
    var existingCharacters =
        Set<CharacterEntity>.from(await _getAllCharacters());
    existingCharacters.removeWhere(
        (existingCharacter) => existingCharacter.id == character.id);
    await _updateCharacters(updatedCharacters: existingCharacters);
  }

  Stream<Set<CharacterEntity>> _getAllCharactersStream() {
    final BehaviorSubject<Set<CharacterEntity>> behaviorSubject =
        BehaviorSubject.seeded({});

    Hive.openBox(charactersBox).then(
      (box) {
        final charactersStream = box.watch(key: charactersKey).asyncMap(
              (boxEvent) => _decodeCharactersFromJson(boxEvent.value),
            );

        final characterStreamSub =
            charactersStream.listen((event) => behaviorSubject.add(event));

        behaviorSubject.doOnCancel(
          () {
            characterStreamSub.cancel();
            box.close();
          },
        );
      },
    );

    return behaviorSubject;
  }

  Future<Set<CharacterEntity>> _getAllCharacters() async {
    final box = await Hive.openBox(charactersBox);
    final allCharactersJson = box.get(charactersKey);
    final allCharacters = _decodeCharactersFromJson(allCharactersJson);
    await box.close();
    return allCharacters;
  }

  Future<void> _updateCharacters(
      {required Set<CharacterEntity> updatedCharacters}) async {
    final box = await Hive.openBox(charactersBox);
    await box.put(charactersKey, _encodeCharactersIntoJson(updatedCharacters));
    await box.close();
  }

  Set<CharacterEntity> _decodeCharactersFromJson(String json) {
    final List<dynamic> jsonList = jsonDecode(json);
    final listOfCharacters = jsonList
        .map((characterInJson) => CharacterEntity.fromJson(characterInJson))
        .toSet();
    return listOfCharacters;
  }

  String _encodeCharactersIntoJson(Iterable<CharacterEntity> characters) {
    return jsonEncode(characters.toList());
  }

  Future<void> _initiateCharactersDataSource() async {
    final box = await Hive.openBox(charactersBox);
    await box.put(charactersKey, jsonEncode(''));
    await box.close();
  }
}
