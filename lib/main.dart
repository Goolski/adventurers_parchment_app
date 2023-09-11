import 'dart:io';

import 'package:dnd_app/entities/spell_entity.dart';
import 'package:dnd_app/presentation/large_layout/spell_details_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data_sources/spells_data_source.dart';
import 'di/di.dart';
import 'presentation/my_theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  Hive.initFlutter();
  Injector.setup();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const AllSpellsView(),
    );
  }
}

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
    return SafeArea(
      child: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('All spells'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorite spells'),
              )
            ],
            selectedIndex: 0,
          ),
          Expanded(
            child: Scaffold(
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
            ),
          ),
        ],
      ),
    );
  }
}
