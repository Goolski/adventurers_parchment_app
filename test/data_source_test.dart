import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/data_sources/data_source_interface.dart';
import 'package:adventurers_parchment/data_sources/database.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final john = CharacterEntity.empty(characterName: 'John');
  final andrew = CharacterEntity.empty(characterName: 'Andrew');
  final jacob = CharacterEntity.empty(characterName: 'Jacob');

  final initialCharacters = [john, andrew, jacob];

  late ICrudDataSource<CharacterEntity> dataSource;

  setUp(
    () {
      dataSource = CharactersLocalDataSource(
        Database<CharacterEntity>(
          initList: initialCharacters,
        ),
      );
    },
  );

  test('You should be able to get item by Id when subscribing to stream',
      () async {
    final StreamSubscription strSub =
        dataSource.get(id: john.id).listen((event) {
      expect(event, john);
    });
    strSub.cancel();
  });

  test(
      'You should be able to get all current items only by subscribing to stream',
      () async {
    final StreamSubscription strSub = dataSource.getAll().listen((event) {
      expect(event, initialCharacters);
    });
    strSub.cancel();
  });

  test(
    'Adding item to database should result in creating the object in database',
    () async {
      final newCharacter = CharacterEntity.empty(characterName: 'new');

      final charactersBeforeAdding = await dataSource.getAll().first;
      expect(charactersBeforeAdding.contains(newCharacter), false);

      dataSource.add(item: newCharacter);

      final charactersAfterAdding = await dataSource.getAll().first;
      expect(charactersAfterAdding.contains(newCharacter), true);
    },
  );

  test('Deleting an item should result in deleting it from database', () async {
    final charactersBeforeDeleting = await dataSource.getAll().first;
    expect(charactersBeforeDeleting.contains(john), true);

    dataSource.delete(item: john);

    final charactersAfterDeleting = await dataSource.getAll().first;
    expect(charactersAfterDeleting.contains(john), false);
  });

  (test(
    'Updating an item should not delete it temporarily',
    () async {
      final updatedJohn = john.copyWith(name: 'updatedJohn');
      final updatedCharacters = [updatedJohn, andrew, jacob];

      expectLater(
        dataSource.getAll(),
        emitsInOrder([equals(initialCharacters), equals(updatedCharacters)]),
      );

      await dataSource.update(item: updatedJohn);
    },
  ));
}
