import 'world.dart';
import '../items/item.dart';
import '../items/inventory_item.dart';
import '../items/loot_item.dart';
import '../items/weapon.dart';
import '../items/healing_potion.dart';
import '../creatures/monster.dart';
import '../quests/quest.dart';
import '../location.dart';


/// the tutorial world from https://scottlilly.com/learn-c-by-building-a-simple-rpg-index/
class Tutoria implements World {
  static final Map<ItemID, Item> items = {
    ItemID.rustySword: new Weapon(ItemID.rustySword, "Rusty Sword", "Rusty Swords", "1d4 + 1"),
    ItemID.club: new Weapon(ItemID.club, "Club", "Clubs", "1d6"),
    ItemID.ratTail: new Item(ItemID.ratTail, "Rat Tail", "Rat Tails"),
    ItemID.pieceOfFur: new Item(ItemID.pieceOfFur, "Piece of Fur", "Pieces of Fur"),
    ItemID.snakeFang: new Item(ItemID.snakeFang, "Snake Fang", "Snake Fangs"),
    ItemID.snakeSkin: new Item(ItemID.snakeSkin, "Snakeskin", "Snakeskins"),
    ItemID.spiderFang: new Item(ItemID.spiderFang, "Spider Fang", "Spider Fangs"),
    ItemID.spiderSilk: new Item(ItemID.spiderSilk, "Spider Silk", "Spider Silks"),
    ItemID.adventurerPass: new Item(ItemID.adventurerPass, "Adventurer Pass", "Adventurer Passes"),
    ItemID.healingPotion: new HealingPotion("2d4")
  };

  static final Map<MonsterID, Monster> monsters = {
    MonsterID.rat: new Monster(MonsterID.rat, "Rat", "1d4 - 1", "1d1", 5, 0, <LootItem>[
      new LootItem(items[ItemID.ratTail], 50),
      new LootItem(items[ItemID.pieceOfFur], 70)
    ]),
    MonsterID.snake: new Monster(MonsterID.snake, "Snake", "1d4 + 1", "1d4", 10, 0, <LootItem>[
      new LootItem(items[ItemID.snakeFang], 50),
      new LootItem(items[ItemID.snakeSkin], 70)
    ]),
    MonsterID.giantSpider: new Monster(MonsterID.giantSpider, "Giant Spider", "3d10", "1d8 + 3", 10, 50, <LootItem>[
      new LootItem(items[ItemID.spiderFang], 75),
      new LootItem(items[ItemID.spiderSilk], 75)
    ])
  };

  static final Map<QuestID, Quest> quests = {
    QuestID.clearAlchemistsGarden: new Quest(QuestID.clearAlchemistsGarden,
      "Clear the Alchemist's Garden",
      "Kill rats in the alchemist's garden and bring back 3 rat tails. You will receive a healing potion and 10 gold pieces.",
      30, gold: 10, item: items[ItemID.healingPotion],
      questCompletionItems: <InventoryItem>[
        new InventoryItem(items[ItemID.ratTail], 3)
      ]
    ),
    QuestID.clearFarmersField: new Quest(QuestID.clearFarmersField,
      "Clear the Farmer's Field",
      "Kill snakes in the farmer's field and bring back 3 snake fangs. You will receive an adventurer's pass and 20 gold pieces.",
      50, gold: 20, item: items[ItemID.adventurerPass],
      questCompletionItems: <InventoryItem>[
        new InventoryItem(items[ItemID.snakeFang], 3)
      ]
    ),
  };
  
  static final Map<LocationID, Location> locations = {
    LocationID.home: new Location(LocationID.home, "Home", "Your house. You really need to clean up the place.")
  };
}