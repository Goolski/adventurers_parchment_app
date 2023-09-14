// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../entities/spell_entity.dart';

class SpellDetailsWidgetPaper extends StatelessWidget {
  const SpellDetailsWidgetPaper({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpellNameWidget(spell: spell),
        Text('Level ${spell.level} spell'),
        Text('Duration:    ${spell.duration}'),
        Text('Components: ${componentsToStr(spell.components)}'),
        Text('Range:    ${spell.range}'),
        Expanded(
          child: SpellDescriptionWidget(spell: spell),
        ),
      ],
    );
  }

  String componentsToStr(Set<SpellComponent> components) {
    String str = '';
    if (components.contains(SpellComponent.verbal)) str += 'V ';
    if (components.contains(SpellComponent.somatic)) str += 'S ';
    if (components.contains(SpellComponent.material)) str += 'M';
    return str;
  }
}

class SpellNameWidget extends StatelessWidget {
  const SpellNameWidget({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return Text(
      spell.name,
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.start,
    );
  }
}

class SpellDescriptionWidget extends StatelessWidget {
  const SpellDescriptionWidget({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        spell.desc.join("\n\n"),
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4),
      ),
    );
  }
}

class SpellLevelWidget extends StatelessWidget {
  const SpellLevelWidget({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      child: Text(
        spell.level.toString(),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image(
          image: AssetImage('assets/paper.jpg'),
          fit: BoxFit.cover,
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
