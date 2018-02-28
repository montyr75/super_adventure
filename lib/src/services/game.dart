import 'logger_service.dart';
import '../models/worlds/world.dart';
import '../models/creatures/player.dart';
import '../models/location.dart';

class Game {
  final LoggerService _log;

  World _world;
  Player _player;
  Location _location;

  Game(LoggerService this._log) {
    _log.info("$runtimeType::Game()");
  }

  void newGame(World world) {
    _log.info("$runtimeType::newGame() -- World: ${world.name}");

    // save reference to world
    _world = world;

    // create player
    _player = new Player("Russell");

    // start player at home
    movePlayer(_world.locations[LocationID.home]);
  }

  void movePlayer(Location loc) {
    _log.info("$runtimeType::movePlayer() -- ${loc.name}");

    // player heals during travel
    player.heal();

    if (!_checkForRequiredItem(loc)) {
      return;
    }

    _location = loc;

    _checkQuests(loc);
    _checkMonsters(loc);
  }

  bool _checkForRequiredItem(Location loc) {
    if (loc.requiresItemToEnter) {
      if (player.hasItem(loc.itemToEnter)) {
        // TODO: Create message: "You use your ${loc.itemToEnter.name} to enter ${loc.name}."
        return true;
      }
      else {
        // TODO: Create message: "You must have the ${loc.itemToEnter.name} to enter ${loc.name}."
        return false;
      }
    }

    return true;
  }

  void _checkQuests(Location loc) {

  }

  void _checkMonsters(Location loc) {

  }

  Player get player => _player;
  Location get location => _location;
}