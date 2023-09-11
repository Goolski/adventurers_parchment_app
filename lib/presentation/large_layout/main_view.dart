import 'package:flutter/material.dart';

import 'all_spells_view.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.list),
              label: Text('All spells'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.favorite),
              label: Text('Favorite spells'),
            )
          ],
          selectedIndex: 0,
        ),
        const Expanded(
          child: AllSpellsView(),
        ),
      ],
    );
  }
}
