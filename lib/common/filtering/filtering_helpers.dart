import 'package:equatable/equatable.dart';

class SelectableElement<U> extends Equatable {
  final U element;
  final bool isSelected;

  SelectableElement({
    required this.element,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [element, isSelected];
}

List<F> getAllOptionsFrom<T, F>(
  List<T> listOfObject,
  F Function(T object) acquireField,
) {
  return listOfObject
      .map((parentObject) => acquireField(parentObject))
      .toSet()
      .toList();
}
