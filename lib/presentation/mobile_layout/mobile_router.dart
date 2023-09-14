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
        ),
      ],
      builder: (context, state, child) => MainScaffold(
        child: child,
      ),
    )
  ],
);
