import 'package:dnd_app/entities/spell_entity.dart';
import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../di/di.dart';
import '../common_widgets/spell_details_widget/spell_details_widget_paper.dart';

class SpellDetailsView extends StatefulWidget {
  final SpellEntity spell;
  const SpellDetailsView({
    super.key,
    required this.spell,
  });

  @override
  State<SpellDetailsView> createState() => _SpellDetailsViewState();
}

class _SpellDetailsViewState extends State<SpellDetailsView> {
  late Future<SpellEntityWithDetails> spellFuture;

  @override
  void initState() {
    spellFuture = Injector.resolve<SpellsDataSource>()
        .getDetailsForSpell(spell: widget.spell);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spell.name),
      ),
      body: FutureBuilder(
        future: spellFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: SpellDetailsWidgetPaper(spell: snapshot.data!),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
