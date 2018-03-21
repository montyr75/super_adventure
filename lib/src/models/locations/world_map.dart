import 'location.dart';

class WorldMap {
  final int mapWidth;
  final Map<int, Map<int, Location>> map;

  WorldMap(this.mapWidth, this.map);

  factory WorldMap.fromLocations(int mapWidth, List<Location> locations) {
    Map<int, Map<int, Location>> map = {};

    for (Location loc in locations) {
      map[loc.coords.row] ??= {};
      map[loc.coords.row][loc.coords.col] = loc;
    }

    return new WorldMap(mapWidth, map);
  }

  /// returns a list of lists, leaving out unnecessary rows and columns
  List<List<Location>> toList() {
    // find the bounding rect
    int firstRow = map.keys.first;
    int lastRow = map.keys.last + 1;
    int firstCol = 0;
    int lastCol = 0;

    // create rows full of null
    List<List<Location>> locs = new List.generate(lastRow - firstRow, (_) => new List.filled(mapWidth, null, growable: false), growable: false);

    // where locations exist, replace nulls
    for (int row = firstRow, i = 0; row < lastRow; row++, i++) {
      if (map[row] == null) {
        locs[i] = new List.filled(mapWidth, null, growable: false);
      }
      else {
        for (int col = 0; col < mapWidth; col++) {
          if (map[row][col] != null) {
            locs[i][col] = map[row][col];

            if (col < firstCol) {
              firstCol = col;
            }

            if (col > lastCol) {
              lastCol = col;
            }
          }
        }
      }
    }

    // shave off empty columns
    for (int row = 0; row < locs.length; row++) {
      locs[row] = locs[row].sublist(firstCol, lastCol + 1);
    }

    return locs;
  }

  @override String toString() {
    List<List<Location>> locs = toList();

    StringBuffer sb = new StringBuffer();

    for (int row = 0; row < locs.length; row++) {
      for (int col = 0; col < locs[row].length; col++) {
        sb.write(locs[row][col] == null ? '-' : locs[row][col].name[0]);
      }

      sb.writeln();
    }

    return sb.toString();
  }
}