import 'live_creature.dart';
import '../items/item.dart';
import '../items/weapon.dart';
import '../items/inventory_item.dart';
import '../quests/quest.dart';
import '../quests/player_quest.dart';

class Player extends Object with LiveCreature {
  static const int MAX_LEVEL = 20;
  static final List<int> levelTable = [];

  final String name;

  int _ac;

  int _xp = 0;
  int _level = 1;
  int _gold = 20;

  List<InventoryItem> _inventory = [];
  List<PlayerQuest> _quests = [];

  Player([this.name = "Hero"]) {
    _generateLevelTable();
    setMaxHP(10);
    _ac = _calculateAC();
    heal();
  }

  bool hasItem(Item item, [int qty]) => inventory.any((InventoryItem value) {
    if (value.details.id == item.id && (qty == null || value.qty >= qty)) {
      return true;
    }

    return false;
  });

  bool hasQuest(Quest quest) => quests.any((PlayerQuest value) => value.details.id == quest.id);
  bool isQuestCompleted(Quest quest) => _quests.any((PlayerQuest value) => value.details.id == quest.id && value.isCompleted);

  bool hasQuestItems(Quest quest) {
    for (InventoryItem item in quest.questCompletionItems) {
      if (!hasItem(item.details, item.qty)) {
        return false;
      }
    }

    return true;
  }

  void gainGold(int gold) => _gold += gold;
  void gainQuest(Quest quest) => _quests.add(new PlayerQuest(quest));

  void completeQuest(Quest quest) {
    // remove quest completion items
    for (InventoryItem item in quest.questCompletionItems) {
      loseItem(item.details, item.qty);
    }

    // mark quest as completed
    _getPlayerQuest(quest).complete();
  }

  void gainXP(int newXP) {
    _xp += newXP;

    int oldLevel = level;

    // have we passed the XP threshold for a new level?
    for (int i = MAX_LEVEL - 1; i >= 0; i--) {
      if (xp >= levelTable[i]) {
        _level = i + 1;
        break;
      }
    }

    // did we level up?
    if (level != oldLevel) {
      setMaxHP(level * 10);
      heal();
    }
  }

  void gainItem(Item item, [int qty = 1]) {
    InventoryItem existingItem = _getInventoryItem(item);

    if (existingItem != null) {
      existingItem.increaseQty(qty);
    }
    else {
      inventory.add(new InventoryItem(item, qty));
    }
  }

  void loseItem(Item item, [int qty = 1]) {
    InventoryItem existingItem = _getInventoryItem(item);

    if (existingItem != null) {
      existingItem.decreaseQty(qty);

      if (existingItem.qty <= 0) {
        inventory.remove(existingItem);
      }
    }
  }

  int _calculateAC() {
    // TODO: Eventually base this on armor and DEX

    return 12;
  }

  InventoryItem _getInventoryItem(Item item) => inventory.firstWhere((InventoryItem value) => value.details.id == item.id, orElse: () => null);
  PlayerQuest _getPlayerQuest(Quest quest) => quests.firstWhere((PlayerQuest value) => value.details.id == quest.id, orElse: () => null);

  void _generateLevelTable() {
    int threshold = 0;
    for (int i = 0; i < MAX_LEVEL; i++) {
      if (i == 0) {
        threshold = 0;
      }
      else if (i == 1) {
        threshold = 100;
      }
      else {
        threshold += threshold * 2;
      }

      levelTable.add(threshold);
    }
  }

  int get ac => _ac;
  int get xp => _xp;
  int get level => _level;
  int get gold => _gold;

  int get attackBonus => level;

  List<InventoryItem> get inventory => _inventory;
  List<PlayerQuest> get quests => _quests;
  List<Weapon> get weapons => inventory.where((InventoryItem item) => item.details.type == 'weapon').map((InventoryItem item) => item.details).toList();
  List<InventoryItem> get potions => inventory.where((InventoryItem item) => item.details.type == 'potion').toList();
}