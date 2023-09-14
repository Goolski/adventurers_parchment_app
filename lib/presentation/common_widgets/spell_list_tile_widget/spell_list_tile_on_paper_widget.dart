import 'package:flutter/material.dart';

import '../../../entities/spell_entity.dart';
import '../../large_layout/spell_details_view.dart';

class SpellListTileOnPaperWidget extends StatelessWidget {
  final SpellEntity spell;
  const SpellListTileOnPaperWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(context),
      child: Text(
        spell.name,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.start,
      ),
    );
  }

  void onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SpellDetailsView(
          spell: spell,
        ),
      ),
    );
  }
}
