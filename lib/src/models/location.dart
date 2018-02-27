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
  Location _north;
  Location _east;
  Location _south;
  Location _west;

  Location(this.id, this.name, this.description, {this.itemToEnter, this.quest, this.monster});

  void linkLocations({Location north, Location east, Location south, Location west}) {
    _north = north;
    _east = east;
    _south = south;
    _west = west;
  }

  Location get north => _north;
  Location get east => _east;
  Location get south => _south;
  Location get west => _west;

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