import '../items/item.dart';
import '../creatures/monster.dart';
import '../quests/quest.dart';
import '../location.dart';

abstract class World {
  static Map<ItemID, Item> items;
  static Map<MonsterID, Monster> monsters;
  static Map<QuestID, Quest> quests;
  static Map<LocationID, Location> locations;
}