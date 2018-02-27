import '../items/loot_item.dart';
import '../items/inventory_item.dart';
import '../../utils/roller.dart';

class Monster {
  final MonsterID id;
  final String name;
  final String hpFormula;
  final String dmgFormula;
  final int xp;
  final int gold;

  List<LootItem> _lootTable;

  DiceExpression _dmg;

  Monster(this.id, this.name, this.hpFormula, this.dmgFormula, this.xp, this.gold, [this._lootTable]) {
    _dmg = new DiceExpression.fromFormula(dmgFormula);
  }

  int attack() => Roller.rollDiceExp(dmg);

  List<InventoryItem> loot() {
    if (_lootTable != null && _lootTable.isNotEmpty) {
      List<InventoryItem> items = [];

      // add drops
      for (LootItem item in _lootTable) {
        if (Roller.rollDie(100) <= item.dropPercentage) {
          items.add(new InventoryItem(item.details, 1));
        }
      }

      return items.isNotEmpty ? items : null;
    }

    return null;
  }

  DiceExpression get dmg => _dmg;
}

enum MonsterID {
  rat,
  snake,
  giantSpider
}