import 'package:dnd_app/presentation/common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/all_spell_view_controller.dart';

class AllSpellsMobileView extends StatelessWidget {
  const AllSpellsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChangeNotifierProvider(
        create: (context) => AllSpellsViewController(
          (message) => showSnackbarMessage(message, context),
        ),
        child: Consumer<AllSpellsViewController>(
          builder: (context, controller, child) {
            if (controller.spells.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (controller.availableButtons.contains('levels')) ...[
                        Chip(label: Text('Levels')),
                      ],
                      if (controller.availableButtons.contains('classes')) ...[
                        Chip(label: Text('Classes')),
                      ],
                      if (controller.availableButtons.contains('schools')) ...[
                        Chip(label: Text('Schools'))
                      ]
                    ],
                  ),
                  if (controller.availableButtons.contains('levels')) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                            .map(
                              (e) => Row(
                                children: [
                                  SelectableNumberWidgetButton(
                                    doSomething: () {},
                                    isSelected: false,
                                    text: e.toString(),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.spells.length,
                        itemBuilder: (context, index) => Align(
                          alignment: Alignment.center,
                          child: SpellListTileOnPaperWidget(
                            spell: controller.spells[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
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

class SelectableNumberWidgetButton extends StatelessWidget {
  const SelectableNumberWidgetButton({
    super.key,
    required this.doSomething,
    required this.isSelected,
    required this.text,
  });

  final String text;
  final Function() doSomething;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => doSomething(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 32),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Color(0x55000000) : Colors.transparent,
            border: Border.all(),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
