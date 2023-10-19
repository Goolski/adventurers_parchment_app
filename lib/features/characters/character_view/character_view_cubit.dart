import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CharacterViewCubit extends Cubit<CharacterViewState> {
  CharacterViewCubit({
    required this.characterId,
    required this.charactersLocalDataSource,
  }) : super(CharacterViewState(null)) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;
  late StreamSubscription streamSubscription;
  final String characterId;

  _init() {
    streamSubscription = charactersLocalDataSource
        .getSingleCharacter(id: characterId)
        .listen((character) {
      emit(CharacterViewState(character));
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

class CharacterViewState extends Equatable {
  final CharacterEntity? character;

  const CharacterViewState(this.character);

  @override
  List<Object?> get props => [character];
}
