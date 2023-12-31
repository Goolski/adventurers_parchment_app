import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    context.go('/spells/${spell.index}');
  }
}
