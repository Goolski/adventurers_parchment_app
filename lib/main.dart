import 'dart:io';

import 'package:dnd_app/spells_data_source.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AllSpellsView(),
    );
  }
}

class AllSpellsView extends StatefulWidget {
  const AllSpellsView({super.key});

  @override
  State<AllSpellsView> createState() => _AllSpellsViewState();
}

class _AllSpellsViewState extends State<AllSpellsView> {
  late final Future<List<String>> spells;

  @override
  void initState() {
    spells = SpellsDataSource().getAllSpellNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: spells,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {},
                  title: Text(
                    snapshot.data![index],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
