import 'dart:async';

import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCharactersWidgetCubit extends Cubit<ListOfCharactersWidgetState> {
  ListOfCharactersWidgetCubit(
    this.charactersLocalDataSource,
  ) : super(
          ListOfCharactersWidgetState(
            characters: [],
          ),
        ) {
    _init();
  }

  late StreamSubscription streamSub;
  final CharactersLocalDataSource charactersLocalDataSource;

  _init() {
    final allCharactersStream = charactersLocalDataSource.getAllCharacters();
    streamSub = allCharactersStream.listen(
      (setOfCharacters) async {
        emit(ListOfCharactersWidgetState(characters: setOfCharacters.toList()));
      },
    );
  }

  @override
  Future<void> close() async {
    streamSub.cancel();
    super.close();
  }
}

class ListOfCharactersWidgetState extends Equatable {
  const ListOfCharactersWidgetState({required this.characters});

  final List<CharacterEntity> characters;

  @override
  List<Object?> get props => [characters];
}
