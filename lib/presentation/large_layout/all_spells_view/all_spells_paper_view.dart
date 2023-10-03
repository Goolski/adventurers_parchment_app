import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data_sources/spells/spells_data_source.dart';
import '../../../di/di.dart';
import '../../../entities/spell_entity.dart';
import '../../common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';

class AllSpellsPaperView extends StatelessWidget {
  const AllSpellsPaperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AllSpellsViewController(
          (message) => showSnackbarMessage(message, context),
        ),
        child: Consumer<AllSpellsViewController>(
          builder: (context, controller, child) {
            switch (controller.spells.isNotEmpty) {
              case true:
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(
                      image: AssetImage('assets/paper.jpg'),
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Container(
                        width: 600,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Here is the list of all the spells',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: 25,
                                  itemBuilder: (context, index) => Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SpellListTileOnPaperWidget(
                                            spell: controller.spells[index],
                                          ),
                                          Text('${index + 1}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              case false:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  void showSnackbarMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class AllSpellsViewController extends ChangeNotifier {
  AllSpellsViewController(this.showErrorMessage) {
    _init();
  }

  Function(String) showErrorMessage;

  List<SpellEntity> _spells = [];
  List<SpellEntity> get spells => _spells;

  final SpellsDataSource _spellsDataSource =
      Injector.resolve<SpellsDataSource>();

  Future<void> _init() async {
    try {
      await getSpells();
    } catch (e) {
      showErrorMessage('Error');
    }
  }

  Future<void> getSpells() async {
    final newSpells = await _spellsDataSource.getSpellsWithDetails();
    _spells = newSpells;
    notifyListeners();
  }
}
