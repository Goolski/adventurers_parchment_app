import 'package:adventurers_parchment/features/characters/create_character_view/create_character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../presentation/DTOs/selectable_DTO.dart';
import 'create_character_state.dart';

class CreateCharacterView extends StatelessWidget {
  const CreateCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocProvider<CreateCharacterCubit>(
        create: (context) => Injector.resolve<CreateCharacterCubit>(),
        child: BlocBuilder<CreateCharacterCubit, CreateCharacterState>(
          builder: (context, state) {
            final cubit = context.read<CreateCharacterCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Create New Character', textAlign: TextAlign.center),
                CharacterForm(
                  characterClasses: state.characterClasses,
                  onCharacterClassPressed: (selected) =>
                      cubit.onCharacterClassPressed(selected),
                  onCharacterNameChanged: (characterName) =>
                      cubit.onCharacterNameChanged(characterName),
                ),
                OutlinedButton(
                  child: state is CreateCharacterStateSaving
                      ? Text('Saving Your Character...')
                      : Text('Save Character'),
                  onPressed: () {
                    cubit.onSaveCharacterPressed();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CharacterForm extends StatelessWidget {
  const CharacterForm({
    super.key,
    required this.onCharacterNameChanged,
    required this.onCharacterClassPressed,
    required this.characterClasses,
  });

  final Function(String characterName) onCharacterNameChanged;
  final Function(SelectableDTO selected) onCharacterClassPressed;
  final List<SelectableDTO> characterClasses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Text(
              'Name: ',
            ),
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (characterName) =>
                    onCharacterNameChanged(characterName),
              ),
            ),
          ],
        ),
        Text('Class'),
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 4,
          spacing: 4,
          children: characterClasses
              .map(
                (e) => FilterChip(
                  label: Text(e.thing),
                  selected: e.isSelected,
                  onSelected: (_) {
                    onCharacterClassPressed(e);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
