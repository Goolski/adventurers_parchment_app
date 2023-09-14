import 'package:dnd_app/entities/spell_entity.dart';
import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../di/di.dart';
import '../common_widgets/spell_details_widget/spell_details_widget_paper.dart';

class SpellDetailsView extends StatefulWidget {
  final String spellIndex;
  const SpellDetailsView({
    super.key,
    required this.spellIndex,
  });

  @override
  State<SpellDetailsView> createState() => _SpellDetailsViewState();
}

class _SpellDetailsViewState extends State<SpellDetailsView> {
  late Future<SpellEntityWithDetails> spellFuture;

  @override
  void initState() {
    spellFuture = Injector.resolve<SpellsDataSource>()
        .getDetailsForSpellByIndex(spellIndex: widget.spellIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: spellFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SpellDetailsWidgetPaper(spell: snapshot.data!),
            ),
          );
        } else {
          return const Center(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}
