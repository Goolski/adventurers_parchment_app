import 'package:adventurers_parchment/features/characters/list_of_characters_wiget/list_of_characters_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';

class ListOfCharactersWidget extends StatelessWidget {
  const ListOfCharactersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListOfCharactersWidgetCubit>(
      create: (context) => Injector.resolve<ListOfCharactersWidgetCubit>(),
      child:
          BlocBuilder<ListOfCharactersWidgetCubit, ListOfCharactersWidgetState>(
        builder: (context, state) => Column(
          children: state.characters
              .map(
                (e) => TextButton(
                  onPressed: () => context.go('/character/${e.id}'),
                  child: Text(e.name),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
