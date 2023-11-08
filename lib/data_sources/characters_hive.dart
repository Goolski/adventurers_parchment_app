import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'database.dart';
import '../entities/character_entity.dart';

const charactersBox = 'characters';
const charactersKey = 'characters';

class CharactersHive implements Database<CharacterEntity> {
  CharactersHive() {
    _init();
  }

  late final StreamController<List<CharacterEntity>> _controller =
      BehaviorSubject(
    onListen: () => _emitCurrentValue(),
  );

  @override
  void dispose() {
    _controller.close();
  }

  @override
  set list(List<CharacterEntity> newList) {
    _update(newList);
  }

  @override
  Stream<List<CharacterEntity>> get stream => _controller.stream;

  void _emitCurrentValue() async {
    final currentValue = await _getCurrentValue();
    _controller.sink.add(currentValue);
  }

  void _update(List<CharacterEntity> items) async {
    final box = await Hive.openBox(charactersBox);
    await box.put(
      charactersKey,
      _encodeCharactersIntoJson(items),
    );
  }

  Future<List<CharacterEntity>> _getCurrentValue() async {
    final box = await Hive.openBox(charactersBox);
    final characters = box.get(charactersKey);
    if (characters == null) {
      await _initiateBoxWithEmptyList(box);
      return [];
    } else {
      return _decodeCharactersFromJson(characters);
    }
  }

  void _init() async {
    _emitCurrentValue();

    final box = await Hive.openBox(charactersBox);

    box
        .watch(key: charactersKey)
        .asyncMap(
          (boxEvent) => _decodeCharactersFromJson(
            boxEvent.value,
          ),
        )
        .listen(
      (newList) {
        _emitCurrentValue();
      },
    );
  }

  Future<void> _initiateBoxWithEmptyList(Box<dynamic> box) async {
    await box.put(charactersKey, _encodeCharactersIntoJson([]));
  }

  String _encodeCharactersIntoJson(Iterable<CharacterEntity> characters) {
    return jsonEncode(characters.toList());
  }

  List<CharacterEntity> _decodeCharactersFromJson(String json) {
    final List<dynamic> jsonList = jsonDecode(json);
    final listOfCharacters = jsonList
        .map((characterInJson) => CharacterEntity.fromJson(characterInJson))
        .toList();
    return listOfCharacters;
  }
}
