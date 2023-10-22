import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../di/di.dart';
import '../../features/characters/character_view/character_view.dart';
import '../../data_sources/characters_local_data_source.dart';
import '../../features/characters/blocs/character_cubit/character_cubit.dart';
import 'spell_details_view.dart';
import 'all_spells_mobile_view/all_spells_mobile_view_new.dart';
import '../../features/characters/create_character_view/create_character_view.dart';
import 'favorite_spells_mobile_view.dart';
import 'main_menu_view.dart';
import 'main_scaffold.dart';

final router = GoRouter(
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MainMenuView(),
          routes: [
            GoRoute(
              path: 'spells/favorite',
              builder: (context, state) => FavoriteSpellsMobileView(),
            ),
            GoRoute(
              path: 'spells',
              builder: (context, state) => AllSpellsMobileViewNew(),
              routes: [
                GoRoute(
                  path: ':spellId',
                  builder: (context, state) => SpellDetailsView(
                    spellIndex: state.pathParameters['spellId']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'create_character',
              builder: (context, state) => CreateCharacterView(),
            ),
            GoRoute(
              path: 'character/:id',
              builder: (context, state) => BlocProvider<CharacterCubit>(
                create: (context) => CharacterCubit(
                  characterId: state.pathParameters['id']!,
                  charactersLocalDataSource:
                      Injector.resolve<CharactersLocalDataSource>(),
                ),
                child: const CharacterView(),
              ),
              routes: [
                GoRoute(
                  path: 'spell/:id',
                  builder: (context, state) => SpellDetailsView(
                    spellIndex: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'licenses',
              builder: (context, state) => LicensePage(),
            ),
          ],
        ),
      ],
      builder: (context, state, child) => MainScaffold(
        child: child,
      ),
    )
  ],
);
