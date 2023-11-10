import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_class_entity.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:bloc/bloc.dart';

import 'create_character_state.dart';

class CreateCharacterCubit extends Cubit<CreateCharacterState> {
  CreateCharacterCubit(
    this.charactersLocalDataSource,
  ) : super(
          const CreateCharacterState(
            characterName: '',
            selectedCharacterClasses: [],
          ),
        );

  final CharactersLocalDataSource charactersLocalDataSource;

  onCharacterNameChanged(String characterName) {
    emit(state.copyWith(characterName: characterName));
  }

  onCharacterClassesUpdated(List<CharacterClassEntity> characterClasses) {
    final newState = state.copyWith(selectedCharacterClasses: characterClasses);
    emit(newState);
  }

  Future<void> onSaveCharacterPressed() async {
    emit(
      CreateCharacterStateSaving(
        characterName: state.characterName,
        selectedCharacterClasses: state.selectedCharacterClasses,
      ),
    );

    var selectedClasses = state.selectedCharacterClasses;

    final newCharacter = CharacterEntity.empty(
      characterName: state.characterName,
      characterClasses: selectedClasses,
    );

    await charactersLocalDataSource.add(
      item: newCharacter,
    );

    emit(
      CreateCharacterStateSaved(
        characterName: state.characterName,
        selectedCharacterClasses: state.selectedCharacterClasses,
      ),
    );
  }
}
