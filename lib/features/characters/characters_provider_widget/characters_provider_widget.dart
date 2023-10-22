import 'package:adventurers_parchment/features/characters/blocs/characters_cubit/characters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../entities/character_entity.dart';

class CharactersProviderWidget extends StatelessWidget {
  const CharactersProviderWidget({
    super.key,
    required this.builder,
  });
  final Widget Function(List<CharacterEntity> characters) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersCubit>(
      create: (context) => Injector.resolve<CharactersCubit>(),
      child: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) => builder(state.characters),
      ),
    );
  }
}
