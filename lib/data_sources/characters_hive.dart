import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'database.dart';
import '../entities/character_entity.dart';

const charactersBox = 'characters';
const charactersKey = 'characters';

class CharactersHive implements Database<CharacterEntity> {
  CharactersHive() : _list = [] {
    _init();
  }

  late final StreamController<List<CharacterEntity>> _controller =
      StreamController.broadcast(
    onListen: () => _emitCurrentValue(),
  );
  List<CharacterEntity> _list;

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

  void _emitCurrentValue() {
    _controller.sink.add(_list);
  }

  void _update(List<CharacterEntity> items) async {
    final box = await Hive.openBox(charactersBox);
    await box.put(
      charactersKey,
      _encodeCharactersIntoJson(items),
    );
  }

  void _init() async {
    final box = await Hive.openBox(charactersBox);
    final characters = box.get(charactersKey);
    if (characters == null) {
      await box.put(charactersKey, _encodeCharactersIntoJson([]));
    }

    box
        .watch(key: charactersKey)
        .asyncMap(
          (boxEvent) => _decodeCharactersFromJson(
            boxEvent.value,
          ),
        )
        .listen(
      (newList) {
        _list = newList;
        _emitCurrentValue();
      },
    );
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
