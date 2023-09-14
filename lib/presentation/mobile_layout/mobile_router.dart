import 'package:dnd_app/presentation/large_layout/spell_details_view.dart';
import 'package:dnd_app/presentation/mobile_layout/all_spells_mobile_view.dart';
import 'package:dnd_app/presentation/mobile_layout/main_menu_view.dart';
import 'package:dnd_app/presentation/mobile_layout/main_scaffold.dart';
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
              path: 'spells',
              builder: (context, state) => AllSpellsMobileView(),
              routes: [
                GoRoute(
                  path: ':spellId',
                  builder: (context, state) => SpellDetailsView(
                    spellIndex: state.pathParameters['spellId']!,
                  ),
                ),
              ],
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
