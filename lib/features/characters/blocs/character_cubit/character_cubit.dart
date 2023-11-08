import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit({
    required this.charactersLocalDataSource,
    required this.characterId,
  }) : super(const CharacterState(null)) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;
  final String characterId;
  late StreamSubscription streamSubscription;

  Future<void> addSpell({
    required String spellId,
  }) async {
    final character = state.character;
    if (character != null && !character.spellIds.contains(spellId)) {
      final updatedCharacter = character.copyWith(
        spellIds: List.from(character.spellIds)..add(spellId),
      );

      await _updateCharacter(updatedCharacter);
    }
  }

  removeSpell(String spellId) {
    final currentCharacter = state.character;
    if (currentCharacter != null) {
      var newSpells = List<String>.from(currentCharacter.spellIds);
      newSpells.removeWhere((element) => element == spellId);
      _updateCharacter(currentCharacter.copyWith(spellIds: newSpells));
    }
  }

  _updateCharacter(CharacterEntity updatedCharacter) async {
    await charactersLocalDataSource.update(item: updatedCharacter);
    emit(CharacterState(updatedCharacter));
  }

  _init() {
    streamSubscription = charactersLocalDataSource
        .get(
      id: characterId,
    )
        .listen(
      (character) {
        emit(CharacterState(character));
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

class CharacterState extends Equatable {
  final CharacterEntity? character;

  const CharacterState(
    this.character,
  );

  @override
  List<Object?> get props => [character];
}
