import 'package:dnd_app/entities/spell_entity.dart';
import 'package:dnd_app/presentation/common_widgets/spell_details_widget.dart';
import 'package:dnd_app/spells_data_source.dart';
import 'package:flutter/material.dart';

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
    spellFuture = SpellsDataSource().getDetailsForSpell(spell: widget.spell);
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
                child: SpellDetailsWidget(spell: snapshot.data!),
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
