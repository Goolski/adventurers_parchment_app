import 'package:flutter/material.dart';

import '../../data_sources/spells_data_source.dart';
import '../../entities/spell_entity.dart';
import 'spell_details_view.dart';

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
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SpellDetailsView(
                        spell: snapshot.data![index],
                      ),
                    ),
                  );
                },
                title: Text(
                  snapshot.data![index].name,
                ),
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
