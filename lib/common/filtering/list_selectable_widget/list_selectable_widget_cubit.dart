import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../filtering_helpers.dart';

class ListSelectableWidgetCubit<T, U>
    extends Cubit<ListSelectableWidgetState<T, U>> {
  ListSelectableWidgetCubit({
    required this.options,
    required this.aquireProperty,
    this.test,
  }) : super(
          ListSelectableWidgetState<T, U>(
            elements: [],
          ),
        ) {
    init();
  }

  final List<U> options;
  final U Function(T) aquireProperty;
  final bool Function(T)? test;

  void init() {
    final selectableOptions = options
        .map(
          (o) => SelectableElement<U>(
            element: o,
            isSelected: false,
          ),
        )
        .toList();

    emit(ListSelectableWidgetState(elements: selectableOptions));
  }

  void onElementPressed(SelectableElement<U> pressedElement) {
    List<SelectableElement<U>> elements = List.from(state.elements);
    final indexOfPressedElement = elements.indexOf(pressedElement);

    elements[indexOfPressedElement] = SelectableElement(
      element: pressedElement.element,
      isSelected: !pressedElement.isSelected,
    );

    emit(
      ListSelectableWidgetState(elements: elements),
    );
  }
}

class ListSelectableWidgetState<T, U> extends Equatable {
  final List<SelectableElement<U>> elements;

  const ListSelectableWidgetState({required this.elements});

  @override
  List<Object?> get props => [elements];
}
