import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/entities/character_class_entity.dart';
import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:adventurers_parchment/presentation/DTOs/selectable_DTO.dart';
import 'package:bloc/bloc.dart';

import 'create_character_state.dart';

class CreateCharacterCubit extends Cubit<CreateCharacterState> {
  CreateCharacterCubit(
    this.charactersLocalDataSource,
  ) : super(
          CreateCharacterState(
            characterName: '',
            characterClasses: [],
          ),
        ) {
    _init();
  }

  final CharactersLocalDataSource charactersLocalDataSource;

  onCharacterNameChanged(String characterName) {
    emit(state.copyWith(characterName: characterName));
  }

  onCharacterClassPressed(SelectableDTO pressedCharacterClass) {
    final indexOfCharacterClass =
        state.characterClasses.indexOf(pressedCharacterClass);

    SelectableDTO newStateOfPressedCharacter = pressedCharacterClass.copyWith(
      isSelected: !pressedCharacterClass.isSelected,
    );

    final updatedCharacterClasses =
        List<SelectableDTO>.from(state.characterClasses)
          ..replaceRange(indexOfCharacterClass, indexOfCharacterClass + 1,
              [newStateOfPressedCharacter]);

    final newState = state.copyWith(characterClasses: updatedCharacterClasses);
    emit(newState);
  }

  Future<void> onSaveCharacterPressed() async {
    emit(
      CreateCharacterStateSaving(
        characterName: state.characterName,
        characterClasses: state.characterClasses,
      ),
    );

    var selectedClasses = state.characterClasses
        .where((element) => element.isSelected)
        .map((e) => defaultListOfCharacterClasses
            .firstWhere((element) => element.name == e.thing))
        .toList();
    final newCharacter = CharacterEntity.empty(
        characterName: state.characterName, characterClasses: selectedClasses);
    await charactersLocalDataSource.add(item: newCharacter);
    emit(
      CreateCharacterStateSaved(
          characterName: state.characterName,
          characterClasses: state.characterClasses),
    );
  }

  _init() {
    final allClasses = defaultListOfCharacterClasses.map((e) => e.name);

    emit(
      CreateCharacterState(
        characterName: '',
        characterClasses: allClasses
            .map(
              (e) => SelectableDTO(thing: e, isSelected: false),
            )
            .toList(),
      ),
    );
  }
}
