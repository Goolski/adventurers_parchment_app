import 'package:adventurers_parchment/common/filtering/filtering_helpers.dart';
import 'package:adventurers_parchment/common/filtering/list_selectable_widget/list_selectable_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListSelectableFilterWidget<T, U> extends StatelessWidget {
  final List<U> options;
  final U Function(T object) aquireProperty;
  final String Function(U property) acquireText;
  final bool Function(T object)? test;

  const ListSelectableFilterWidget({
    required this.options,
    required this.aquireProperty,
    required this.acquireText,
    this.test,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ListSelectableWidgetCubit<T, U>,
          ListSelectableWidgetState<T, U>>(
        builder: (context, state) => Row(
          children: state.elements
              .map(
                (elem) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FilterChip(
                    onSelected: (_) => onElementPressed(context, elem),
                    label: Text(acquireText(elem.element)),
                    selected: elem.isSelected,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void onElementPressed(BuildContext context, SelectableElement<U> elem) {
    return context
        .read<ListSelectableWidgetCubit<T, U>>()
        .onElementPressed(elem);
  }
}
