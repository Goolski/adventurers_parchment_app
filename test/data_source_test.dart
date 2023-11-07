import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/data_sources/data_source_interface.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ICrudDataSource dataSource = CharactersLocalDataSource();
  final character = CharacterEntity.empty(characterName: 'John');
  test(
    'Adding item to database should result in creating the object in database',
    () async {
      final StreamSubscription strSub = dataSource.getAll().listen((event) {
        expect(event.contains(character), true);
      });
      await dataSource.add(item: character);
      strSub.cancel();
    },
  );

  test('Deleting an item should result in deleting it from database', () async {
    dataSource.add(item: character);
    final StreamSubscription strSub = dataSource.getAll().listen((event) {
      expect(event.contains(character), false);
    });
    await dataSource.delete(item: character);
    strSub.cancel();
  });

  test('You should be able to get item by Id when subscribing to stream',
      () async {
    dataSource.add(item: character);
    final StreamSubscription strSub =
        dataSource.get(id: character.id).listen((event) {
      expect(event, character);
    });
    strSub.cancel();
  });

  test(
      'You should be able to get all current items only by subscribing to stream',
      () async {
    final character2 = CharacterEntity.empty(characterName: 'Andrew');
    await dataSource.add(item: character2);
  });
}
