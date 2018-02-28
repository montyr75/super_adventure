import 'items/item.dart';
import 'quests/quest.dart';
import 'creatures/monster.dart';

class Location {
  static const String NAME_COLOR = "blue";

  final LocationID id;
  final String name;
  final String description;

  // optionals
  final Item itemToEnter;
  final Quest quest;
  final Monster monster;

  final Map<Direction, Location> destinations = {};

  Location(this.id, this.name, this.description, {this.itemToEnter, this.quest, this.monster});

  void linkLocations({Location north, Location east, Location south, Location west}) {
    destinations[Direction.north] = north;
    destinations[Direction.east] = east;
    destinations[Direction.south] = south;
    destinations[Direction.west] = west;
  }

  bool get requiresItemToEnter => itemToEnter != null;
  bool get hasQuest => quest != null;
  bool get hasMonster => monster != null;

  // travel destinations
  Location get north => destinations[Direction.north];
  Location get east => destinations[Direction.east];
  Location get south => destinations[Direction.south];
  Location get west => destinations[Direction.west];

  // travel options
  bool get N => north != null;
  bool get E => east != null;
  bool get S => south != null;
  bool get W => west != null;

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';
}

enum LocationID {
  home,
  townSquare,
  alchemistsHut,
  alchemistsGarden,
  farmhouse,
  farmersField,
  guardPost,
  bridge,
  spiderForest
}

enum Direction {
  north,
  east,
  south,
  west
}