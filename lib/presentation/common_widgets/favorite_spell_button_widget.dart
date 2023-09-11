import 'dart:async';

import 'package:dnd_app/data_sources/favorite_spells_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/spell_entity.dart';

class FavoriteSpellButtonWidget extends StatelessWidget {
  final SpellEntity spell;
  const FavoriteSpellButtonWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteSpellController(spell: spell),
      child: Consumer<FavoriteSpellController>(
        builder: (context, favSpellController, child) => IconButton(
          onPressed: () => favSpellController.toggleFavorite(),
          icon: Icon(
            favSpellController.isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}

class FavoriteSpellController extends ChangeNotifier {
  FavoriteSpellController({required this.spell}) {
    init();
  }
  final FavoriteSpellsLocalDataSource localDataSource =
      FavoriteSpellsLocalDataSource();
  late StreamSubscription str;

  final SpellEntity spell;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> init() async {
    final stream =
        await localDataSource.getSingleFavouriteSpellStream(spell: spell);
    str = stream.listen((event) {
      if (event == null) {
        _setFavoriteStateTo(false);
      } else {
        _setFavoriteStateTo(true);
      }
    });
  }

  void toggleFavorite() {
    if (_isFavorite) {
      localDataSource.deleteFavoriteSpell(spell: spell);
    } else {
      localDataSource.addFavouriteSpell(spell: spell);
    }
  }

  void _setFavoriteStateTo(bool state) {
    _isFavorite = state;
    notifyListeners();
  }

  @override
  void dispose() {
    str.cancel();
    super.dispose();
  }
}