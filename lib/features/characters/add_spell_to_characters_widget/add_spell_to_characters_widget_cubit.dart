import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class AddSpellToCharactersWidgetCubit
    extends Cubit<AddSpellToCharactersWidgetState> {
  AddSpellToCharactersWidgetCubit() : super(AddSpellToCharactersWidgetState());

  onSpellAdded() {
    emit(AddSpellToCharactersWidgetStateSelecting());
  }

  onCharacterSelected(String selectedCharacterId) {
    emit(AddSpellToCharactersWidgetStateSaving(selectedCharacterId));
  }
}

class AddSpellToCharactersWidgetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddSpellToCharactersWidgetStateSaving
    extends AddSpellToCharactersWidgetState {
  final String selectedCharacterId;

  AddSpellToCharactersWidgetStateSaving(this.selectedCharacterId);

  @override
  List<Object?> get props => [selectedCharacterId];
}

class AddSpellToCharactersWidgetStateSelecting
    extends AddSpellToCharactersWidgetState {
  @override
  List<Object?> get props => [];
}
