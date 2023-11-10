import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/character_class_entity.dart';
import '../../../presentation/DTOs/selectable_DTO.dart';
import 'select_character_classes_widget_state.dart';

class SelectCharacterClassesWidgetCubit
    extends Cubit<SelectCharacterClassesWidgetState> {
  SelectCharacterClassesWidgetCubit()
      : super(const SelectCharacterClassesWidgetState([])) {
    _init();
  }

  void onCharacterClassPressed(SelectableDTO selected) {
    final indexOfOriginal = state.characterClasses.indexOf(selected);

    final updated = selected.copyWith(isSelected: !selected.isSelected);

    final allSelectable = List<SelectableDTO>.from(state.characterClasses);

    allSelectable.replaceRange(indexOfOriginal, indexOfOriginal + 1, [updated]);

    emit(
      SelectCharacterClassesWidgetState(allSelectable),
    );
  }

  void _init() {
    final characterClassNames =
        defaultListOfCharacterClasses.map((e) => e.name);

    final selectableDtos = characterClassNames
        .map((e) => SelectableDTO(isSelected: false, thing: e))
        .toList();

    emit(
      SelectCharacterClassesWidgetState(selectableDtos),
    );
  }
}
