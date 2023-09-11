import 'package:flutter/material.dart';

import '../../entities/spell_entity.dart';
import '../large_layout/spell_details_view.dart';

class SpellListTileWidget extends StatelessWidget {
  final SpellEntity spell;
  const SpellListTileWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SpellDetailsView(
              spell: spell,
            ),
          ),
        );
      },
      title: Text(
        spell.name,
      ),
    );
  }
}
