import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/data_sources/data_source_interface.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../entities/character_class_entity.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit({
    required this.charactersLocalDataSource,
    required this.characterId,
  }) : super(LoadingCharacter()) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;
  final String characterId;
  late StreamSubscription streamSubscription;

  Future<void> addSpell({
    required String spellId,
  }) async {
    if (state is! CharacterLoaded) {
      return;
    }
    final character = (state as CharacterLoaded).character;
    if (!character.spellIds.contains(spellId)) {
      final updatedCharacter = character.copyWith(
        spellIds: List.from(character.spellIds)..add(spellId),
      );

      await _updateCharacter(updatedCharacter);
    }
  }

  Future<void> updateThisCharacter({
    String? name,
    List<CharacterClassEntity>? characterClasses,
  }) async {
    if (state is! CharacterLoaded) {
      return;
    }
    final character = (state as CharacterLoaded).character;

    final updatedCharacter = character.copyWith(
      name: name,
      characterClasses: characterClasses,
    );
    await charactersLocalDataSource.update(
      item: updatedCharacter,
    );
  }

  Future<void> deleteThisCharacter() async {
    if (state is! CharacterLoaded) {
      return;
    }
    final character = (state as CharacterLoaded).character;
    await charactersLocalDataSource.delete(item: character);
  }

  removeSpell(String spellId) {
    if (state is! CharacterLoaded) {
      return;
    }
    final currentCharacter = (state as CharacterLoaded).character;
    var newSpells = List<String>.from(currentCharacter.spellIds);
    newSpells.removeWhere((element) => element == spellId);
    _updateCharacter(currentCharacter.copyWith(spellIds: newSpells));
  }

  _updateCharacter(CharacterEntity updatedCharacter) async {
    await charactersLocalDataSource.update(item: updatedCharacter);
  }

  _init() {
    streamSubscription = charactersLocalDataSource
        .get(
      id: characterId,
    )
        .listen(
      (character) {
        emit(CharacterLoaded(character));
      },
      onError: (error, stackTrace) {
        _onStreamError(error, stackTrace);
      },
    );
  }

  void _onStreamError(error, stackTrace) {
    if (error is ItemDeletedException) {
      emit(CharacterDeleted());
    }
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

abstract class CharacterState {}

class LoadingCharacter implements CharacterState {}

class CharacterLoaded extends Equatable implements CharacterState {
  const CharacterLoaded(this.character);

  final CharacterEntity character;

  @override
  List<Object?> get props => [character];
}

class CharacterDoesNotExist implements CharacterState {}

class CharacterDeleted implements CharacterState {}
