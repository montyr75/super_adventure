import 'items/item.dart';
import 'quests/quest.dart';
import 'creatures/monster.dart';

class Location {
  final LocationID id;
  final String name;
  final String description;

  // optionals
  final Item itemToEnter;
  final Quest quest;
  final Monster monster;

  // travel
  final Location north;
  final Location east;
  final Location south;
  final Location west;

  Location(this.id, this.name, this.description, {this.itemToEnter, this.quest, this.monster, this.north, this.east, this.south, this.west});

  bool get requiresItemToEnter => itemToEnter != null;
  bool get hasQuest => quest != null;
  bool get hasMonster => monster != null;

  bool get N => north != null;
  bool get E => east != null;
  bool get S => south != null;
  bool get W => west != null;
}

enum LocationID {
  home,
  townSquare,
  alchemistsHut,
  alchemistsGarden,
  farmhouse,
  farmersfield,
  guardPost,
  bridge,
  spiderForest
}