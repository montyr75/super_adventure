import 'map_coords.dart';
import '../items/item.dart';
import '../quests/quest.dart';
import '../creatures/monster.dart';
import '../../utils/roller.dart';

class Location implements Comparable<Location> {
  static const String NAME_COLOR = "blue";

  final LocationID id;
  final MapCoords coords;
  final String name;
  final String description;

  // optionals
  final Item itemToEnter;
  final Quest quest;
  final List<LocationMonster> monsters;

  Location(this.id, this.coords, this.name, this.description, {this.itemToEnter, this.quest, this.monsters});

  bool get requiresItemToEnter => itemToEnter != null;
  bool get hasQuest => quest != null;
  bool get hasMonster => monsters != null && monsters.isNotEmpty;

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';

  LocationMonster getMonster() {
    if (hasMonster) {
      for (LocationMonster monster in monsters) {
        if (Roller.rollDie(100) <= monster.appearancePercentage && monster.active) {
          return monster;
        }
      }
    }

    return null;
  }

  /// sort locations based on map row (WorldMap likes this)
  int compareTo(Location other) {
    if (coords.row < other.coords.row) {
      return -1;
    }
    else if (coords.row > other.coords.row) {
      return 1;
    }
    else {
      return 0;
    }
  }

  @override String toString() => "$name $coords";
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
  spiderForest,
  eastWard,
  tundra,
  barbarianCamp,
  goblinMountain
}

enum Direction {
  north,
  east,
  south,
  west
}