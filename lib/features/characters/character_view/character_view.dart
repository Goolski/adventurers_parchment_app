import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:adventurers_parchment/features/characters/blocs/character_cubit/character_cubit.dart';
import 'package:adventurers_parchment/features/characters/character_view/character_view_cubit.dart';
import 'package:adventurers_parchment/features/characters/select_character_classes_widget/select_character_classes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../entities/character_class_entity.dart';
import '../list_of_character_spells_widget/list_of_character_spells_widget.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
      listener: (context, state) {
        if (state is CharacterDeleted) {
          final snackBar = SnackBar(content: Text('Character Deleted'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.pop();
        }
        if (state is CharacterDoesNotExist) {
          final snackBar = SnackBar(content: Text("Character Doesn't exist"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.go('/');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CharacterLoaded:
            final character = (state as CharacterLoaded).character;
            return NewWidget(
              character: character,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterViewCubit>(
      create: (context) => CharacterViewCubit(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CharacterViewCubit, CharacterViewState>(
          builder: (context, state) {
            final cubit = context.read<CharacterViewCubit>();
            switch (state) {
              case CharacterViewState.display:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CharacterNameWidget(character: character),
                    if (character.characterClasses.isNotEmpty) ...[
                      ListOfCharacterClassesWidget(character: character),
                    ],
                    Row(
                      children: [
                        const Text(
                          'Spells',
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => cubit.requestEdit(),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: ListOfCharacterSpellsWidget(
                          character: character,
                        ),
                      ),
                    ),
                  ],
                );
              case CharacterViewState.edit:
                return EditingCharacterWidget(
                  cubit: cubit,
                  character: character,
                );
            }
          },
        ),
      ),
    );
  }
}

class EditingCharacterWidget extends StatefulWidget {
  const EditingCharacterWidget({
    super.key,
    required this.cubit,
    required this.character,
  });

  final CharacterViewCubit cubit;
  final CharacterEntity character;

  @override
  State<EditingCharacterWidget> createState() => _EditingCharacterWidgetState();
}

class _EditingCharacterWidgetState extends State<EditingCharacterWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  List<CharacterClassEntity> _selectedCharacterClasses = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.character.name);
    _selectedCharacterClasses = widget.character.characterClasses;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(prefix: Text('Name: ')),
            controller: _controller,
            validator: (value) => CharacterEntity.validateName(name: value),
          ),
          Text("Classes"),
          SelectCharacterClassesWidget(
            onUpdate: (characterClasses) => setState(() {
              _selectedCharacterClasses = characterClasses;
            }),
            initiallySelectedClasses: widget.character.characterClasses,
          ),
          Row(
            children: [
              const Text(
                'Spells',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _showDeleteConfirmationDialog(context),
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newName = _controller.text;
                    final newCharacterClassees = _selectedCharacterClasses;
                    await context.read<CharacterCubit>().updateThisCharacter(
                          name: newName,
                          characterClasses: newCharacterClassees,
                        );
                    widget.cubit.requestSave();
                  }
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              child: ListOfCharacterSpellsWidget(
                character: widget.character,
                isEditing: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Character"),
          content: Text("Are you sure you want to delete this character?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<CharacterCubit>().deleteThisCharacter();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

class CharacterNameWidget extends StatelessWidget {
  const CharacterNameWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.name,
      textAlign: TextAlign.center,
    );
  }
}

class ListOfCharacterClassesWidget extends StatelessWidget {
  const ListOfCharacterClassesWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Text(
      character.characterClasses
          .map((characterClass) => characterClass.name)
          .join(', '),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
