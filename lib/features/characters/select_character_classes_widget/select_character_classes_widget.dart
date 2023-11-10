import 'package:adventurers_parchment/features/characters/select_character_classes_widget/select_character_classes_widget_cubit.dart';
import 'package:adventurers_parchment/features/characters/select_character_classes_widget/select_character_classes_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/character_class_entity.dart';

class SelectCharacterClassesWidget extends StatelessWidget {
  const SelectCharacterClassesWidget({super.key, this.onUpdate});

  final Function(List<CharacterClassEntity> characterClasses)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SelectCharacterClassesWidgetCubit>(
      create: (context) => SelectCharacterClassesWidgetCubit(),
      child: BlocConsumer<SelectCharacterClassesWidgetCubit,
          SelectCharacterClassesWidgetState>(
        listener: (context, state) {
          _castToCharacterClassesAndUpdate(state);
        },
        builder: (context, state) {
          final characterClasses = state.characterClasses;
          final cubit = context.read<SelectCharacterClassesWidgetCubit>();
          return Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 4,
            spacing: 4,
            children: characterClasses
                .map(
                  (e) => FilterChip(
                    label: Text(e.thing),
                    selected: e.isSelected,
                    onSelected: (_) {
                      cubit.onCharacterClassPressed(e);
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  void _castToCharacterClassesAndUpdate(
      SelectCharacterClassesWidgetState state) {
    final selectedNames = state.characterClasses
        .where((element) => element.isSelected)
        .map((e) => e.thing);
    final selectedCharacterClasses = defaultListOfCharacterClasses
        .where(
          (element) => selectedNames.contains(element.name),
        )
        .toList();
    if (onUpdate != null) {
      onUpdate!(selectedCharacterClasses);
    }
  }
}
