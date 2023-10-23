import 'package:adventurers_parchment/data_sources/characters_local_data_source.dart';
import 'package:adventurers_parchment/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/character_entity.dart';
import '../blocs/character_cubit/character_cubit.dart';

class CharacterProviderWidget extends StatelessWidget {
  const CharacterProviderWidget({
    super.key,
    required this.characterId,
    required this.builder,
  });

  final String characterId;
  final Widget Function(BuildContext context, CharacterEntity? character)
      builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterCubit>(
      create: (context) => CharacterCubit(
        charactersLocalDataSource:
            Injector.resolve<CharactersLocalDataSource>(),
        characterId: characterId,
      ),
      child: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) => builder(context, state.character),
      ),
    );
  }
}
