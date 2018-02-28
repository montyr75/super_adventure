import 'logger_service.dart';
import '../models/worlds/world.dart';
import '../models/creatures/player.dart';
import '../models/creatures/live_monster.dart';
import '../models/items/inventory_item.dart';
import '../models/location.dart';
import '../models/message.dart';

class Game {
  final LoggerService _log;

  World _world;
  Player _player;
  Location _location;
  LiveMonster _monster;

  List<Message> _messages = [];

  Game(LoggerService this._log) {
    _log.info("$runtimeType::Game()");
  }

  void newGame(World world) {
    // save reference to world
    _world = world;

    // create player
    _player = new Player("Russell");

    // start player at home
    movePlayer(_world.locations[LocationID.home]);
  }

  void movePlayer(Location loc) {
    // running away, eh?
    if (_monster != null) {
      _message(new Message("You bravely flee from the ${_monster.htmlName}."));
      _monster = null;
    }
    
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
        _message(new Message("You use your ${loc.itemToEnter.htmlName} to enter ${loc.htmlName}."));
        return true;
      }
      else {
        _message(new Message("You must have the ${loc.itemToEnter.htmlName} to enter ${loc.htmlName}."));
        return false;
      }
    }

    return true;
  }

  void _checkQuests(Location loc) {
    if (loc.hasQuest) {
      if (player.hasQuest(loc.quest)) {
        if (!player.isQuestCompleted(loc.quest) && player.hasQuestItems(loc.quest)) {
          player.completeQuest(loc.quest);

          StringBuffer sb = new StringBuffer();
          sb.writeln("<strong>Quest completed:</strong> ${loc.quest.htmlName}");
          sb.writeln();

          String rewardText = _rewardPlayer(
            xp: loc.quest.xp,
            gold: loc.quest.gold,
            items: loc.quest.hasItem ? [new InventoryItem(loc.quest.item, 1)] : null
          );

          sb.writeln(rewardText);

          _message(new Message(sb.toString()));
        }
      }
      else {
        player.gainQuest(loc.quest);

        StringBuffer sb = new StringBuffer();
        sb.writeln("<strong>New quest:</strong> ${loc.quest.htmlName}");
        sb.writeln();
        sb.writeln(loc.quest.description);
        sb.writeln();
        sb.writeln("To complete this quest, return here with:");

        for (InventoryItem item in loc.quest.questCompletionItems) {
          sb.writeln("${item.qty} ${item.htmlName}");
        }

        _message(new Message(sb.toString()));
      }
    }
  }

  void _checkMonsters(Location loc) {
    if (loc.hasMonster) {
      _monster = new LiveMonster(loc.monster);

      _message(new Message("You see a ${monster.htmlName}!"));
    }
    else {
      _monster = null;
    }
  }

  String _rewardPlayer({int xp, int gold, List<InventoryItem> items}) {
    StringBuffer sb = new StringBuffer();

    sb.writeln("You receive...");

    if (xp != null) {
      player.gainXP(xp);
      sb.writeln("XP: $xp");
    }

    if (gold != null) {
      player.gainGold(gold);
      sb.writeln("Gold: $gold");
    }

    if (items != null && items.isNotEmpty) {
      for (InventoryItem item in items) {
        player.gainItem(item.details, item.qty);
        sb.writeln("${item.qty} ${item.htmlName}");
      }
    }

    return sb.toString();
  }

  void _message(Message msg) {
    messages.add(msg);

    // TODO: limit the number of messages we're storing
  }

  Player get player => _player;
  Location get location => _location;
  LiveMonster get monster => _monster;
  List<Message> get messages => _messages;
}