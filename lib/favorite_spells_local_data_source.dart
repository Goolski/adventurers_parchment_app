import 'package:dnd_app/entities/spell_entity.dart';
import 'package:hive/hive.dart';

const favoriteSpellsBox = 'favorite-spells';

class FavoriteSpellsLocalDataSource {
  Future<void> saveFavouriteSpell({required SpellEntity spell}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    await box.put(spell.index, spell.toJson());
    await box.close();
  }

  Future<void> deleteFavoriteSpell({required SpellEntity spell}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    await box.delete(spell.index);
    await box.close();
  }

  Future<Iterable<SpellEntity>> getAllFavoriteSpells(
      {required SpellEntity spell}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    final spells = await box.values;
    return spells.map((spellJson) => SpellEntity.fromJson(spellJson));
  }
}
