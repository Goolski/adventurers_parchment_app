import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCharacterSpellsWidgetCubit
    extends Cubit<ListOfCharacterSpellsWidgetState> {
  ListOfCharacterSpellsWidgetCubit({bool isInitiallyEdited = false})
      : super(
          isInitiallyEdited
              ? ListOfCharacterSpellsWidgetState.edit
              : ListOfCharacterSpellsWidgetState.display,
        );

  onEditPressed() {
    emit(ListOfCharacterSpellsWidgetState.edit);
  }

  onDonePressed() {
    emit(ListOfCharacterSpellsWidgetState.display);
  }
}

enum ListOfCharacterSpellsWidgetState {
  display,
  edit,
}
