import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCharacterSpellsWidgetCubit
    extends Cubit<ListOfCharacterSpellsWidgetState> {
  ListOfCharacterSpellsWidgetCubit()
      : super(ListOfCharacterSpellsWidgetState.display);

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
