import 'package:equatable/equatable.dart';

import '../../../entities/character_class_entity.dart';

class CreateCharacterState extends Equatable {
  final String characterName;
  final List<CharacterClassEntity> selectedCharacterClasses;

  const CreateCharacterState({
    required this.characterName,
    required this.selectedCharacterClasses,
  });

  @override
  List<Object?> get props => [characterName, selectedCharacterClasses];

  CreateCharacterState copyWith({
    String? characterName,
    List<CharacterClassEntity>? selectedCharacterClasses,
  }) {
    return CreateCharacterState(
      characterName: characterName ?? this.characterName,
      selectedCharacterClasses:
          selectedCharacterClasses ?? this.selectedCharacterClasses,
    );
  }
}

class CreateCharacterStateSaving extends CreateCharacterState {
  CreateCharacterStateSaving({
    required super.characterName,
    required super.selectedCharacterClasses,
  });
}

class CreateCharacterStateSaved extends CreateCharacterState {
  CreateCharacterStateSaved({
    required super.characterName,
    required super.selectedCharacterClasses,
  });
}
