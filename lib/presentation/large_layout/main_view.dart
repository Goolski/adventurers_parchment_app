import 'package:flutter/material.dart';

import 'all_spells_view.dart';

enum MainViewState { allSpells, favoriteSpells }

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late MainViewState navigationState;

  @override
  void initState() {
    super.initState();
    navigationState = MainViewState.favoriteSpells;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          onDestinationSelected: (value) => onDestinationSelected(value),
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
          selectedIndex: navigationState.index,
        ),
        const Expanded(
          child: AllSpellsView(),
        ),
      ],
    );
  }

  void onDestinationSelected(int value) {
    setState(() {
      navigationState = MainViewState.values[value];
    });
  }
}
