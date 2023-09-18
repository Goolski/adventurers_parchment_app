import 'package:dnd_app/presentation/mobile_layout/main_menu_view.dart';
import 'package:flutter/material.dart';

import '../../../entities/spell_entity.dart';

class SpellListTileOnPaperWidget extends StatelessWidget {
  final SpellEntity spell;
  const SpellListTileOnPaperWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(context, spell),
      child: Text(
        spell.name,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.start,
      ),
    );
  }

  void onPressed(BuildContext context, SpellEntity spell) {
    goTo(context, '/spells/${spell.index}');
  }
}
