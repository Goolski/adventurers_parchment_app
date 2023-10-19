import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSpellToCharactersWidgetCubit
    extends Cubit<AddSpellToCharactersWidgetState> {
  AddSpellToCharactersWidgetCubit(
    this.charactersLocalDataSource,
  ) : super(AddSpellToCharactersWidgetState(characters: [])) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;
  late StreamSubscription streamSubscription;

  addSpellToCharacter({
    required CharacterEntity character,
    required String spellId,
  }) async {
    final updatedCharacter = CharacterEntity(
      id: character.id,
      name: character.name,
      characterClasses: character.characterClasses,
      spellIds: character.spellIds..add(spellId),
    );
    await charactersLocalDataSource.update(updatedCharacter: updatedCharacter);
  }

  _init() async {
    final allCharactersStream = charactersLocalDataSource.getAllCharacters();
    streamSubscription = allCharactersStream.listen((setOfCharacters) {
      emit(state.copyWith(characters: setOfCharacters.toList()));
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

class AddSpellToCharactersWidgetState extends Equatable {
  final List<CharacterEntity> characters;

  AddSpellToCharactersWidgetState({required this.characters});

  @override
  List<Object?> get props => [characters];
  AddSpellToCharactersWidgetState copyWith(
      {List<CharacterEntity>? characters}) {
    return AddSpellToCharactersWidgetState(
        characters: characters ?? this.characters);
  }
}
