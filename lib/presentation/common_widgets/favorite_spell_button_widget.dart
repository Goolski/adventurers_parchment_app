import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteSpellButtonWidget extends StatelessWidget {
  const FavoriteSpellButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteSpellController(),
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
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
