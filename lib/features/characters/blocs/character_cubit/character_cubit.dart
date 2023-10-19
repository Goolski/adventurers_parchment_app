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

  removeSpell(String spellId) {
    final currentCharacter = state.character;
    if (currentCharacter != null) {
      var newSpells = List<String>.from(currentCharacter.spellIds);
      newSpells.removeWhere((element) => element == spellId);
      _updateCharacter(currentCharacter.copyWith(spellIds: newSpells));
    }
  }

  _updateCharacter(CharacterEntity updatedCharacter) async {
    await charactersLocalDataSource.update(updatedCharacter: updatedCharacter);
    emit(CharacterState(updatedCharacter));
  }

  _init() {
    streamSubscription = charactersLocalDataSource
        .getSingleCharacter(
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
