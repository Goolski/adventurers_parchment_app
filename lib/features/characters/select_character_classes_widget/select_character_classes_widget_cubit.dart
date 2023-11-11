import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/character_class_entity.dart';
import '../../../presentation/DTOs/selectable_DTO.dart';
import 'select_character_classes_widget_state.dart';

class SelectCharacterClassesWidgetCubit
    extends Cubit<SelectCharacterClassesWidgetState> {
  SelectCharacterClassesWidgetCubit({
    this.initiallySelectedClasses,
  }) : super(
          const SelectCharacterClassesWidgetState(
            [],
          ),
        ) {
    _init();
  }

  final List<CharacterClassEntity>? initiallySelectedClasses;

  void onCharacterClassPressed(SelectableDTO pressed) {
    final updated = _toggleClassFromList(
      selectableList: state.characterClasses,
      toggled: pressed,
    );

    emit(
      SelectCharacterClassesWidgetState(updated),
    );
  }

  List<SelectableDTO> _toggleClassFromList({
    required List<SelectableDTO> selectableList,
    required SelectableDTO toggled,
  }) {
    final indexOfOriginal = state.characterClasses.indexOf(toggled);

    final updated = toggled.copyWith(isSelected: !toggled.isSelected);

    final allSelectable = List<SelectableDTO>.from(state.characterClasses);

    allSelectable.replaceRange(indexOfOriginal, indexOfOriginal + 1, [updated]);

    return allSelectable;
  }

  void _init() {
    final characterClassNames =
        defaultListOfCharacterClasses.map((e) => e.name);

    var selectableDtos = characterClassNames
        .map((e) => SelectableDTO(isSelected: false, thing: e))
        .toList();

    if (initiallySelectedClasses != null) {
      selectableDtos = selectableDtos.map((selectable) {
        if (initiallySelectedClasses!
            .map((e) => e.name)
            .contains(selectable.thing)) {
          return selectable.copyWith(isSelected: true);
        }
        return selectable;
      }).toList();
    }

    emit(
      SelectCharacterClassesWidgetState(selectableDtos),
    );
  }
}
