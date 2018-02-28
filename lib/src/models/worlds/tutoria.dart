import 'world.dart';
import '../items/item.dart';
import '../items/inventory_item.dart';
import '../items/loot_item.dart';
import '../items/weapon.dart';
import '../items/healing_potion.dart';
import '../creatures/monster.dart';
import '../creatures/attack.dart';
import '../quests/quest.dart';
import '../location.dart';


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

    _monsters = {
      MonsterID.rat: new Monster(MonsterID.rat, "Rat", "1d4 - 1", 10, new Attack("Bite", 0, "1d1"), 5, 0, <LootItem>[
        new LootItem(items[ItemID.ratTail], 50),
        new LootItem(items[ItemID.pieceOfFur], 70)
      ]),
      MonsterID.snake: new Monster(MonsterID.snake, "Snake", "1d4 + 1", 12, new Attack("Bite", 3, "1d4"), 10, 0, <LootItem>[
        new LootItem(items[ItemID.snakeFang], 50),
        new LootItem(items[ItemID.snakeSkin], 70)
      ]),
      MonsterID.giantSpider: new Monster(MonsterID.giantSpider, "Giant Spider", "3d10", 14, new Attack("Bite", 5, "1d8 + 3"), 10, 50, <LootItem>[
        new LootItem(items[ItemID.spiderFang], 75),
        new LootItem(items[ItemID.spiderSilk], 75)
      ])
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
      )
    };

    _locations = {
      LocationID.home: new Location(LocationID.home, "Home", "Your house. You really need to clean up the place."),
      LocationID.townSquare: new Location(LocationID.townSquare, "Town Square", "You see a fountain."),
      LocationID.alchemistsHut: new Location(LocationID.alchemistsHut, "Alchemist's Hut", "There are many strange plants on the shelves.",
        quest: quests[QuestID.clearAlchemistsGarden]
      ),
      LocationID.alchemistsGarden: new Location(LocationID.alchemistsGarden, "Alchemist's Garden", "Many plants are growing here.",
        monster: monsters[MonsterID.rat]
      ),
      LocationID.farmhouse: new Location(LocationID.farmhouse, "Farmhouse", "There is a small farmhouse, with a farmer in front.",
        quest: quests[QuestID.clearFarmersField]
      ),
      LocationID.farmersfield: new Location(LocationID.farmersfield, "Farmer's Field", "You see rows of vegetables growing here.",
        monster: monsters[MonsterID.snake]
      ),
      LocationID.guardPost: new Location(LocationID.guardPost, "Guard Post", "There is a large, tough-looking guard here.",
        itemToEnter: items[ItemID.adventurerPass]
      ),
      LocationID.bridge: new Location(LocationID.bridge, "Bridge", "A stone bridge crosses a wide river."),
      LocationID.spiderForest: new Location(LocationID.spiderForest, "Spider Forest", "You see spider webs covering the trees in this forest.",
        monster: monsters[MonsterID.giantSpider]
      )
    };


    // link locations together
    locations[LocationID.home].linkLocations(
      north: locations[LocationID.townSquare]
    );

    locations[LocationID.townSquare].linkLocations(
      north: locations[LocationID.alchemistsHut],
      east: locations[LocationID.guardPost],
      south: locations[LocationID.home],
      west: locations[LocationID.farmhouse]
    );

    locations[LocationID.farmhouse].linkLocations(
      east: locations[LocationID.townSquare],
      west: locations[LocationID.farmersfield]
    );

    locations[LocationID.farmersfield].linkLocations(
      east: locations[LocationID.farmhouse]
    );

    locations[LocationID.alchemistsHut].linkLocations(
      north: locations[LocationID.alchemistsGarden],
      south: locations[LocationID.townSquare]
    );

    locations[LocationID.alchemistsGarden].linkLocations(
      south: locations[LocationID.alchemistsHut]
    );

    locations[LocationID.guardPost].linkLocations(
      east: locations[LocationID.bridge],
      west: locations[LocationID.townSquare]
    );

    locations[LocationID.bridge].linkLocations(
      east: locations[LocationID.spiderForest],
      west: locations[LocationID.guardPost]
    );

    locations[LocationID.spiderForest].linkLocations(
      west: locations[LocationID.bridge]
    );
  }

  Map<ItemID, Item> get items => _items;
  Map<MonsterID, Monster> get monsters => _monsters;
  Map<QuestID, Quest> get quests => _quests;
  Map<LocationID, Location> get locations => _locations;
}