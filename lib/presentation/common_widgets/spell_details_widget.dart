import 'package:dnd_app/entities/spell_entity.dart';
import 'package:dnd_app/presentation/common_widgets/favorite_spell_button_widget.dart';
import 'package:flutter/material.dart';

class SpellDetailsWidget extends StatelessWidget {
  final SpellEntityWithDetails spell;

  const SpellDetailsWidget({
    super.key,
    required this.spell,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  color: Colors.green[600],
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    child: Text(
                      spell.level.toString(),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: FavoriteSpellButtonWidget(),
                )
              ],
            ),
            GridView.count(
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SpellRangeWidget(spell: spell),
                SpellDurationWidget(spell: spell),
                SpellComponentsWidget(components: spell.components),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    spell.desc.join("\n\n"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpellDurationWidget extends StatelessWidget {
  const SpellDurationWidget({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Duration'),
        Text(spell.duration),
      ],
    );
  }
}

class SpellRangeWidget extends StatelessWidget {
  const SpellRangeWidget({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Range'),
        Text(
          spell.range,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class SpellComponentsWidget extends StatelessWidget {
  final Set<SpellComponent> components;
  const SpellComponentsWidget({
    super.key,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Components'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (components.contains(SpellComponent.verbal)) ...[
              Text('V'),
              SizedBox(width: 8)
            ],
            if (components.contains(SpellComponent.somatic)) ...[
              Text('S'),
              SizedBox(width: 8)
            ],
            if (components.contains(SpellComponent.material)) ...[Text('M')],
          ],
        ),
      ],
    );
  }
}
