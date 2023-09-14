import 'dart:async';

import 'package:dnd_app/data_sources/favorite_spells_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/spell_entity.dart';
import '../common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';

class FavoriteSpellsMobileView extends StatelessWidget {
  const FavoriteSpellsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteSpellsController>(
      create: (context) => FavoriteSpellsController(),
      child: Consumer<FavoriteSpellsController>(
          builder: (context, controller, child) {
        if (controller.spells.isEmpty) {
          return Center(
            child: Text(
              "You don't have any \n favorite spells yet",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.spells.length,
            itemBuilder: (context, index) => Align(
              alignment: Alignment.center,
              child: SpellListTileOnPaperWidget(
                spell: controller.spells[index],
              ),
            ),
          );
        }
      }),
    );
  }
}

class FavoriteSpellsController extends ChangeNotifier {
  FavoriteSpellsController() {
    init();
  }

  final FavoriteSpellsLocalDataSource favoriteSpellsLocalDataSource =
      FavoriteSpellsLocalDataSource();
  late StreamSubscription streamSubscription;

  List<SpellEntity> _spells = [];
  List<SpellEntity> get spells => _spells;

  void init() async {
    final stream =
        await favoriteSpellsLocalDataSource.getAllFavoriteSpellsStream();
    streamSubscription = stream.listen((newSpells) {
      updateSpells(newSpells: newSpells);
    });
  }

  void updateSpells({required Set<SpellEntity> newSpells}) {
    _spells = newSpells.toList();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}
