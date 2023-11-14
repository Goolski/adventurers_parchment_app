import 'package:adventurers_parchment/entities/character_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character Tests', () {
    test(
      'Character cannot have multiple spells with the same Id',
      () {
        final character = CharacterEntity.empty(characterName: 'John');
        const spellId = '123';

        final updatedCharacter =
            character.copyWith(spellIds: [spellId, spellId]);

        expect(updatedCharacter.spellIds, [spellId]);
      },
    );
  });
}
