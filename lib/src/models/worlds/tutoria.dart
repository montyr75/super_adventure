import 'world.dart';
import '../items/item.dart';
import '../items/inventory_item.dart';
import '../items/loot_item.dart';
import '../items/weapon.dart';
import '../items/healing_potion.dart';
import '../creatures/monster.dart';
import '../creatures/attack.dart';
import '../quests/quest.dart';
import '../locations/location.dart';
import '../locations/map_coords.dart';


/// the tutorial world from https://scottlilly.com/learn-c-by-building-a-simple-rpg-index
class Tutoria implements World {
  String get name => runtimeType.toString();

  Map<ItemID, Item> _items;
  Map<MonsterID, Monster> _monsters;
  Map<QuestID, Quest> _quests;
  Map<LocationID, Location> _locations;

  Tutoria() {
    _items = {
      ItemID.rustySword: new Weapon(ItemID.rustySword, "Rusty Sword", "Rusty Swords", "1d4 + 1"),
      ItemID.club: new Weapon(ItemID.club, "Club", "Clubs", "1d6 + 1"),
      ItemID.longsword: new Weapon(ItemID.longsword, "Longsword", "Longswords", "1d8 + 1"),
      ItemID.ratTail: new Item(ItemID.ratTail, "Rat Tail", "Rat Tails"),
      ItemID.pieceOfFur: new Item(ItemID.pieceOfFur, "Piece of Fur", "Pieces of Fur"),
      ItemID.snakeFang: new Item(ItemID.snakeFang, "Snake Fang", "Snake Fangs"),
      ItemID.snakeSkin: new Item(ItemID.snakeSkin, "Snakeskin", "Snakeskins"),
      ItemID.spiderFang: new Item(ItemID.spiderFang, "Spider Fang", "Spider Fangs"),
      ItemID.spiderSilk: new Item(ItemID.spiderSilk, "Spider Silk", "Spider Silks"),
      ItemID.adventurerPass: new Item(ItemID.adventurerPass, "Adventurer Pass", "Adventurer Passes"),
      ItemID.venomSack: new Item(ItemID.venomSack, "Venom Sack", "Venom Sacks"),
      ItemID.goblinEar: new Item(ItemID.goblinEar, "Goblin Ear", "Goblin Ears"),
      ItemID.trinket: new Item(ItemID.trinket, "Trinket", "Trinkets"),
      ItemID.healingPotion: new HealingPotion("2d4")
    };

    _monsters = {
      MonsterID.killerRabbit: new Monster(MonsterID.killerRabbit, "Killer Rabbit", "5d6", 15, new Attack("Bite", 6, "2d8"), 200, 50),
      MonsterID.rat: new Monster(MonsterID.rat, "Rat", "1d4 - 1", 10, new Attack("Bite", 0, "1d1"), 5, 0, <LootItem>[
        new LootItem(items[ItemID.ratTail], 50),
        new LootItem(items[ItemID.pieceOfFur], 70)
      ]),
      MonsterID.swarmOfRats: new Monster(MonsterID.swarmOfRats, "Swarm of Rats", "7d8 - 7", 10, new Attack("Bites", 2, "1d6 + 2"), 25, 0, <LootItem>[
        new LootItem(items[ItemID.ratTail], 90),
        new LootItem(items[ItemID.pieceOfFur], 90)
      ]),
      MonsterID.snake: new Monster(MonsterID.snake, "Snake", "1d4 + 1", 12, new Attack("Bite", 3, "1d4"), 10, 0, <LootItem>[
        new LootItem(items[ItemID.snakeFang], 50),
        new LootItem(items[ItemID.snakeSkin], 70)
      ]),
      MonsterID.spider: new Monster(MonsterID.spider, "Spider", "1d4 - 1", 12, new Attack("Bite", 4, "1d1"), 5, 0, <LootItem>[
        new LootItem(items[ItemID.spiderSilk], 75)
      ]),
      MonsterID.swarmOfSpiders: new Monster(MonsterID.swarmOfSpiders, "Swarm of Spiders", "3d8", 12, new Attack("Bites", 3, "2d4"), 35, 0),
      MonsterID.giantSpider: new Monster(MonsterID.giantSpider, "Giant Spider", "3d10", 14, new Attack("Bite", 5, "1d8 + 3"), 100, 50, <LootItem>[
        new LootItem(items[ItemID.spiderFang], 75),
        new LootItem(items[ItemID.spiderSilk], 75),
        new LootItem(items[ItemID.venomSack], 50)
      ]),
      MonsterID.goblin: new Monster(MonsterID.goblin, "Goblin", "1d8 + 2", 13, new Attack("Scimitar", 4, "1d6 + 2"), 15, 1, <LootItem>[
        new LootItem(items[ItemID.goblinEar], 40),
        new LootItem(items[ItemID.trinket], 50)
      ]),
      MonsterID.giantCentipede: new Monster(MonsterID.giantCentipede, "Giant Centipede", "1d6 + 1", 13, new Attack("Bite", 4, "1d4 + 2"), 15, 0)
    };

    _quests = {
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
      QuestID.retrieveSpiderVenomSack: new Quest(QuestID.retrieveSpiderVenomSack,
        "Retrieve Giant Spider Venom Sack",
        "Find and kill a giant spider in the Spider Forest. Cut out its venom sack to save the bridge guard's poisoned daughter. For this, the guard will give you a new weapon.",
        75, gold: 35, item: items[ItemID.longsword],
        questCompletionItems: <InventoryItem>[
          new InventoryItem(items[ItemID.venomSack])
        ]
      ),
      QuestID.quellGoblinThreat: new Quest(QuestID.quellGoblinThreat,
        "Quell the Goblin Threat",
        "The goblins of Goblin Mountain continously harrass the tribe. Thin out their numbers to teach them a lesson. Bring back 3 of their ears to prove the deed done. For this, you will be given a tribal club and 20 gold.",
        100, gold: 20, item: items[ItemID.club],
        questCompletionItems: <InventoryItem>[
          new InventoryItem(items[ItemID.goblinEar], 3)
        ]
      )
    };

    _locations = {
      LocationID.home: new Location(LocationID.home, const MapCoords(19, 10), "Home", "Your house. You really need to clean up the place."),
      LocationID.townSquare: new Location(LocationID.townSquare, const MapCoords(18, 10), "Town Square", "You see a fountain."),
      LocationID.alchemistsHut: new Location(LocationID.alchemistsHut, const MapCoords(17, 10), "Alchemist's Hut", "There are many strange plants on the shelves.",
        quest: quests[QuestID.clearAlchemistsGarden]
      ),
      LocationID.alchemistsGarden: new Location(LocationID.alchemistsGarden, const MapCoords(16, 10), "Alchemist's Garden", "Many plants are growing here.",
        monsters: [
          new LocationMonster(monsters[MonsterID.rat], 70),
          new LocationMonster(monsters[MonsterID.swarmOfRats], 25)
        ]
      ),
      LocationID.farmhouse: new Location(LocationID.farmhouse, const MapCoords(18, 9), "Farmhouse", "There is a small farmhouse, with a farmer in front.",
        quest: quests[QuestID.clearFarmersField]
      ),
      LocationID.farmersField: new Location(LocationID.farmersField, const MapCoords(18, 8), "Farmer's Field", "You see rows of vegetables growing here.",
        monsters: [
          new LocationMonster(monsters[MonsterID.snake], 70),
          new LocationMonster(monsters[MonsterID.killerRabbit], 10)
        ]
      ),
      LocationID.guardPost: new Location(LocationID.guardPost, const MapCoords(18, 12), "Guard Post", "There is a large, tough-looking guard here.",
        itemToEnter: items[ItemID.adventurerPass],
        quest: quests[QuestID.retrieveSpiderVenomSack]
      ),
      LocationID.bridge: new Location(LocationID.bridge, const MapCoords(18, 13), "Bridge", "A stone bridge crosses a wide river."),
      LocationID.spiderForest: new Location(LocationID.spiderForest, const MapCoords(18, 14), "Spider Forest", "You see spider webs covering the trees in this forest.",
        monsters: [
          new LocationMonster(monsters[MonsterID.spider], 50),
          new LocationMonster(monsters[MonsterID.swarmOfSpiders], 30),
          new LocationMonster(monsters[MonsterID.giantSpider], 40)
        ]
      ),
      LocationID.eastWard: new Location(LocationID.eastWard, const MapCoords(18, 11), "East Ward", "Townfolk bustle past you, living out their peasant lives."),
      LocationID.tundra: new Location(LocationID.tundra, const MapCoords(17, 12), "Tundra", "This barren wasteland is home to roving tribes of barbarians."),
      LocationID.barbarianCamp: new Location(LocationID.barbarianCamp, const MapCoords(16, 12), "Barbarian Camp", "The rugged people the barbarian tribe eye you with suspicion as they go about their daily chores.",
        quest: quests[QuestID.quellGoblinThreat]
      ),
      LocationID.goblinMountain: new Location(LocationID.goblinMountain, const MapCoords(15, 12), "Goblin Mountain", "The rocky terrain of the mountain slows your progress. You try to stay alert, wary of attack by the area's ill-tempered denizens.",
        monsters: [
          new LocationMonster(monsters[MonsterID.goblin], 60),
          new LocationMonster(monsters[MonsterID.giantCentipede], 30)
        ]
      ),
    };
  }

  Map<ItemID, Item> get items => _items;
  Map<MonsterID, Monster> get monsters => _monsters;
  Map<QuestID, Quest> get quests => _quests;
  Map<LocationID, Location> get locations => _locations;
  List<Location> get locationsList => locations.values.toList()..sort();
}