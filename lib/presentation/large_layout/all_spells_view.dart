import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/spell_list_tile_widget/spell_list_tile_widget.dart';
import '../controllers/all_spell_view_controller.dart';

class AllSpellsView extends StatelessWidget {
  const AllSpellsView({super.key});

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
                return ListView.builder(
                  itemCount: controller.spells.length,
                  itemBuilder: (context, index) => SpellListTileWidget(
                    spell: controller.spells[index],
                  ),
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
