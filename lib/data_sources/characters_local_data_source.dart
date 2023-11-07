import 'dart:async';

import 'package:adventurers_parchment/entities/character_entity.dart';

import 'data_source_interface.dart';
import 'database.dart';

class CharacterExistsException implements Exception {
  final String message = 'Character with given id already Exists';
}

class CharactersLocalDataSource implements ICrudDataSource<CharacterEntity> {
  final Database<CharacterEntity> db;

  CharactersLocalDataSource(this.db);

  @override
  Future<void> add({required CharacterEntity item}) async {
    List<CharacterEntity> currentItems = await db.stream.first;
    currentItems.add(item);
    db.list = currentItems;
  }

  @override
  Stream<List<CharacterEntity>> getAll() {
    return db.stream;
  }

  @override
  Stream<CharacterEntity> get({required String id}) {
    return db.stream.asyncMap(
      (event) => event.firstWhere((element) => element.id == id),
    );
  }

  @override
  Future<void> update({required CharacterEntity item}) async {
    final CharacterEntity currentValue = await get(id: item.id).first;
    await delete(item: currentValue);
    await add(item: item);
  }

  @override
  Future<void> delete({required CharacterEntity item}) async {
    List<CharacterEntity> currentItems = await db.stream.first;
    await currentItems.remove(item);
    db.list = currentItems;
  }
}
