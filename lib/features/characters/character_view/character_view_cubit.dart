import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterViewCubit extends Cubit<CharacterViewState> {
  CharacterViewCubit() : super(CharacterViewState.display);

  requestEdit() {
    emit(CharacterViewState.edit);
  }

  requestSave() {
    emit(CharacterViewState.display);
  }
}

enum CharacterViewState {
  display,
  edit,
}
