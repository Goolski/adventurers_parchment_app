import 'package:flutter/material.dart';

import '../../entities/spell_entity.dart';

class FavoriteSpellButtonWidget extends StatelessWidget {
  final SpellEntity spell;

  const FavoriteSpellButtonWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.favorite,
      ),
    );
  }
}
