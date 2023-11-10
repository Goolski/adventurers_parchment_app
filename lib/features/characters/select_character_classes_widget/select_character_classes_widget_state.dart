import 'package:equatable/equatable.dart';

import '../../../presentation/DTOs/selectable_DTO.dart';

class SelectCharacterClassesWidgetState extends Equatable {
  final List<SelectableDTO> characterClasses;

  const SelectCharacterClassesWidgetState(this.characterClasses);

  @override
  List<Object?> get props => [characterClasses];
}
