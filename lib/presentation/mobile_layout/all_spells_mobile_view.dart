import 'package:dnd_app/presentation/common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../large_layout/all_spells_view.dart';

class AllSpellsMobileView extends StatelessWidget {
  const AllSpellsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Here is the list of all the spells that I know of',
            textAlign: TextAlign.center,
          ),
          ChangeNotifierProvider(
            create: (context) => AllSpellsViewController(
              (message) => showSnackbarMessage(message, context),
            ),
            child: Consumer<AllSpellsViewController>(
              builder: (context, controller, child) {
                if (controller.spells.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.spells.length,
                      itemBuilder: (context, index) => Align(
                        alignment: Alignment.center,
                        child: SpellListTileOnPaperWidget(
                          spell: controller.spells[index],
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          )
        ],
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
