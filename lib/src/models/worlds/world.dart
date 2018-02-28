import '../items/item.dart';
import '../creatures/monster.dart';
import '../quests/quest.dart';
import '../location.dart';

abstract class World {
  Map<ItemID, Item> _items;
  Map<MonsterID, Monster> _monsters;
  Map<QuestID, Quest> _quests;
  Map<LocationID, Location> _locations;

  String get name;
  Map<ItemID, Item> get items;
  Map<MonsterID, Monster> get monsters;
  Map<QuestID, Quest> get quests;
  Map<LocationID, Location> get locations;
}