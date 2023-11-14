import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectableListWidget extends StatelessWidget {
  const SelectableListWidget({
    required this.options,
    required this.onSelected,
    super.key,
  });

  final List<String> options;
  final Function(List<String> selectedOptions) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectableListCubit(providedOptions: options),
      child: BlocConsumer<SelectableListCubit, SelectableListState>(
        listener: (context, state) => onSelected(state.selectedOptions),
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options
                  .map(
                    (o) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FilterChip(
                        onSelected: (_) =>
                            context.read<SelectableListCubit>().onPressed(o),
                        label: Text(o),
                        selected: state.selectedOptions.contains(o),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class SelectableListCubit extends Cubit<SelectableListState> {
  SelectableListCubit({
    required this.providedOptions,
  }) : super(
          const SelectableListState(
            allOptions: [],
            selectedOptions: [],
          ),
        );

  final List<String> providedOptions;

  void init() {
    emit(
      SelectableListState(
        allOptions: providedOptions,
        selectedOptions: const [],
      ),
    );
  }

  void onPressed(String option) {
    List<String> newSelectedOptions = getUpdatedSelectedOptions(option);
    SelectableListState newState = state.copyWith(
      selectedOptions: newSelectedOptions,
    );
    emit(newState);
  }

  List<String> getUpdatedSelectedOptions(String option) {
    List<String> newSelectedOptions = List.from(state.selectedOptions);
    if (state.selectedOptions.contains(option)) {
      newSelectedOptions.remove(option);
    } else {
      newSelectedOptions.add(option);
    }
    return newSelectedOptions;
  }
}

class SelectableListState extends Equatable {
  const SelectableListState(
      {required this.allOptions, required this.selectedOptions});

  final List<String> allOptions;
  final List<String> selectedOptions;

  SelectableListState copyWith({
    List<String>? allOptions,
    List<String>? selectedOptions,
  }) {
    return SelectableListState(
      allOptions: allOptions ?? this.allOptions,
      selectedOptions: selectedOptions ?? this.selectedOptions,
    );
  }

  @override
  List<Object?> get props => [allOptions, selectedOptions];
}
