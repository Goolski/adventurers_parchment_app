import 'package:adventurers_parchment/presentation/mobile_layout/spell_details_view.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/all_spells_mobile_view_new.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/create_character_view/create_character_view.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/favorite_spells_mobile_view.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/main_menu_view.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
