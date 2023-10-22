import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this.charactersLocalDataSource)
      : super(
          CharactersState(characters: []),
        ) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;
  late StreamSubscription streamSubscription;

  _init() {
    streamSubscription =
        charactersLocalDataSource.getAllCharacters().listen((event) {
      emit(
        CharactersState(
          characters: event.toList(),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

class CharactersState extends Equatable {
  final List<CharacterEntity> characters;

  const CharactersState({
    required this.characters,
  });

  @override
  List<Object?> get props => [characters];
}
