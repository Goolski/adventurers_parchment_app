import 'package:dnd_app/presentation/common_widgets/spell_list_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../entities/spell_entity.dart';

class AllSpellsView extends StatefulWidget {
  const AllSpellsView({super.key});

  @override
  State<AllSpellsView> createState() => _AllSpellsViewState();
}

class _AllSpellsViewState extends State<AllSpellsView> {
  late final Future<List<SpellEntity>> spells;

  @override
  void initState() {
    spells = SpellsDataSource().getSpells();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: spells,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => SpellListTileWidget(
                spell: snapshot.data![index],
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
