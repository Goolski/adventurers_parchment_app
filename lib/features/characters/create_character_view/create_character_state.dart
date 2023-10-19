import 'package:equatable/equatable.dart';

import '../../../presentation/DTOs/selectable_DTO.dart';

class CreateCharacterState extends Equatable {
  final String characterName;
  final List<SelectableDTO> characterClasses;

  const CreateCharacterState({
    required this.characterName,
    required this.characterClasses,
  });

  @override
  List<Object?> get props => [characterName, characterClasses];
  CreateCharacterState copyWith(
      {String? characterName, List<SelectableDTO>? characterClasses}) {
    return CreateCharacterState(
      characterName: characterName ?? this.characterName,
      characterClasses: characterClasses ?? this.characterClasses,
    );
  }
}

class CreateCharacterStateSaving extends CreateCharacterState {
  CreateCharacterStateSaving({
    required super.characterName,
    required super.characterClasses,
  });
}
