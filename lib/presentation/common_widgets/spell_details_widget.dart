import 'package:dnd_app/entities/spell_entity.dart';
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
                )
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      spell.range,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      spell.duration,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: SpellComponentsWidget(components: spell.components),
                  ),
                ],
              ),
            ),
            const Divider(),
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

class SpellComponentsWidget extends StatelessWidget {
  final Set<SpellComponent> components;
  const SpellComponentsWidget({
    super.key,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
