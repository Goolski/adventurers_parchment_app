import 'dart:async';

import 'package:adventurers_parchment/data_sources/favorite_spells_local_data_source.dart';
import 'package:adventurers_parchment/presentation/common_widgets/spell_list_tile_widget/spell_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/spell_entity.dart';

class FavoriteSpellsView extends StatelessWidget {
  const FavoriteSpellsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteSpellsController>(
      create: (context) => FavoriteSpellsController(),
      child: Consumer<FavoriteSpellsController>(
        builder: (context, controller, child) => Scaffold(
          body: ListView.builder(
            itemCount: controller.spells.length,
            itemBuilder: (context, index) => SpellListTileWidget(
              spell: controller.spells[index],
            ),
          ),
        ),
      ),
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
