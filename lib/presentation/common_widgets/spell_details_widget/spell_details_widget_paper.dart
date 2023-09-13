// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../entities/spell_entity.dart';
import '../art_deco_border_widget.dart';
import '../masked_gif_image_widget.dart';

class SpellDetailsWidgetPaper extends StatelessWidget {
  final SpellEntityWithDetails spell;

  const SpellDetailsWidgetPaper({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaskedGifImageWidget(
                image: AssetImage('assets/noise.gif'),
                blendMode: BlendMode.dstIn,
                child: Body(spell: spell),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.spell,
  });

  final SpellEntityWithDetails spell;

  @override
  Widget build(BuildContext context) {
    return ArtDecoBorderWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpellNameWidget(spell: spell),
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
              child: SpellDescriptionWidget(spell: spell),
            ),
          ],
        ),
      ),
    );
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          spell.desc.join("\n\n"),
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4),
        ),
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
