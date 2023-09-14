import 'package:collection/collection.dart';
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
            if (controller.spellsLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpellsFiltersWidget(
                    availableButtons: controller.availableButtons,
                    availableLevels: controller.availableLevels,
                    availableClasses: controller.availableClasses,
                    availableShools: controller.availableSchools,
                    selectedLevels: controller.selectedLevels,
                    selectedClasses: controller.selectedClasses,
                    selectedShools: controller.selectedSchools,
                    onChipClicked: controller.onChipClicked,
                    onClassClicked: controller.onClassClicked,
                    onLevelClicked: controller.onLevelClicked,
                    onSchoolClicked: controller.onSchoolClicked,
                  ),
                  Expanded(
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

class SelectableWidgetButton extends StatelessWidget {
  const SelectableWidgetButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isSelected = false,
  });

  final String text;
  final Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 32),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
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

class SpellsFiltersWidget extends StatelessWidget {
  final List<String> availableButtons;

  final List<String> availableLevels;
  final List<String> availableClasses;
  final List<String> availableShools;

  final List<String> selectedLevels;
  final List<String> selectedClasses;
  final List<String> selectedShools;

  final Function(int index) onChipClicked;
  final Function(int index) onLevelClicked;
  final Function(int index) onClassClicked;
  final Function(int index) onSchoolClicked;

  const SpellsFiltersWidget({
    super.key,
    required this.availableButtons,
    required this.availableLevels,
    required this.availableClasses,
    required this.availableShools,
    required this.selectedLevels,
    required this.selectedClasses,
    required this.selectedShools,
    required this.onChipClicked,
    required this.onLevelClicked,
    required this.onClassClicked,
    required this.onSchoolClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (availableButtons.isNotEmpty) ...[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (availableButtons.contains('levels')) ...[
                    SelectableWidgetButton(
                      onPressed: () => onChipClicked(0),
                      text: 'Levels',
                    ),
                  ],
                  if (availableButtons.contains('classes')) ...[
                    SelectableWidgetButton(
                      onPressed: () => onChipClicked(1),
                      text: 'Classes',
                    ),
                  ],
                  if (availableButtons.contains('schools')) ...[
                    SelectableWidgetButton(
                      onPressed: () => onChipClicked(2),
                      text: 'Schools',
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
        if (!availableButtons.contains('levels')) ...[
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableLevels
                      .mapIndexed(
                        (index, level) => Row(
                          children: [
                            SelectableWidgetButton(
                              onPressed: () => onLevelClicked(index),
                              isSelected: selectedLevels.contains(level),
                              text: level,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          )
        ],
        if (!availableButtons.contains('classes')) ...[
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableClasses
                      .mapIndexed(
                        (index, className) => Row(
                          children: [
                            SelectableWidgetButton(
                              onPressed: () => onClassClicked(index),
                              isSelected: selectedClasses.contains(className),
                              text: className,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          )
        ],
        if (!availableButtons.contains('schools')) ...[
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableShools
                      .mapIndexed(
                        (index, schoolName) => Row(
                          children: [
                            SelectableWidgetButton(
                              onPressed: () => onSchoolClicked(index),
                              isSelected: selectedShools.contains(schoolName),
                              text: schoolName,
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          )
        ],
      ],
    );
  }
}
