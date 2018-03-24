import 'attack.dart';
import 'live_creature.dart';
import '../global.dart';
import '../items/loot_item.dart';
import '../items/inventory_item.dart';
import '../../utils/roller.dart';
import '../../utils/utils.dart';

class Monster {
  final MonsterID id;
  final String name;
  final String hpFormula;
  final int ac;
  final Attack attack;
  final int xp;
  final int gold;

  List<LootItem> _lootTable;

  DiceExpression _dmg;

  Monster(this.id, this.name, this.hpFormula, this.ac, this.attack, this.xp, this.gold, [this._lootTable]);

  DiceExpression get dmg => _dmg;

  String get imgPath => "$MONSTER_IMAGE_PATH/${imgFromName(name)}";
}

class LiveMonster extends Object with LiveCreature {
  static const String NAME_COLOR = "purple";

  final Monster _details;

  LiveMonster(this._details) {
    setMaxHPByFormula(details.hpFormula);
    heal();
  }

  int attack() => details.attack.attack();
  int damage() => details.attack.damage();

  RollResult attackVerbose() => details.attack.attackVerbose();
  RollResult damageVerbose() => details.attack.damageVerbose();

  List<InventoryItem> loot() {
    if (details._lootTable != null && details._lootTable.isNotEmpty) {
      List<InventoryItem> items = [];

      // add drops
      for (LootItem item in details._lootTable) {
        if (Roller.rollDie(100) <= item.dropPercentage) {
          items.add(new InventoryItem(item.details, 1));
        }
      }

      return items.isNotEmpty ? items : null;
    }

    return null;
  }

  Monster get details => _details;

  String get htmlName => '<span style="color: $NAME_COLOR;">${details.name}</span>';
}

class LocationMonster {
  final Monster details;
  final int appearancePercentage;

  bool _active;     // only active monsters will ever appear in a location

  LocationMonster(this.details, this.appearancePercentage, [this._active = true]);

  LiveMonster spawn() => new LiveMonster(details);

  void activate() => _active = true;
  void deactivate() => _active = false;

  bool get active => _active;
}

enum MonsterID {
  rat,
  swarmOfRats,
  snake,
  spider,
  swarmOfSpiders,
  giantSpider,
  killerRabbit,
  goblin,
  giantCentipede
}