import 'package:equatable/equatable.dart';

class SelectableDTO extends Equatable {
  const SelectableDTO({
    required this.thing,
    required this.isSelected,
  });

  final String thing;
  final bool isSelected;

  SelectableDTO copyWith({String? thing, bool? isSelected}) {
    return SelectableDTO(
        thing: thing ?? this.thing, isSelected: isSelected ?? this.isSelected);
  }

  @override
  List<Object?> get props => [thing, isSelected];
}
