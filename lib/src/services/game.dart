import 'logger_service.dart';
import '../models/worlds/world.dart';
import '../models/creatures/player.dart';
import '../models/creatures/live_monster.dart';
import '../models/creatures/attack.dart';
import '../models/items/item.dart';
import '../models/items/inventory_item.dart';
import '../models/items/weapon.dart';
import '../models/location.dart';
import '../models/message.dart';

class Game {
  static const MAX_MESSAGES = 20;

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
    _player = new Player();

    // start player at home
    movePlayer(_world.locations[LocationID.home]);

    // player needs a weapon
    _message(new Message(_rewardPlayer(items: [new InventoryItem(_world.items[ItemID.rustySword])])));
  }

  void movePlayer(Location loc, {bool healPlayer = true}) {
    // running away, eh?
    if (_monster != null) {
      _message(new Message("You bravely flee from the ${_monster.htmlName}."));
      _monster = null;
    }
    
    // player heals during travel
    if (healPlayer) {
      player.heal();
    }

    if (!_checkForRequiredItem(loc)) {
      return;
    }

    _location = loc;

    _checkQuests(loc);
    _checkMonsters(loc);
  }

  void playerAttack(Weapon weapon) {
    if (monster == null) {
      _message(new Message("There is nothing to attack here."));
      return;
    }

    StringBuffer sb = new StringBuffer();

    if (Attack.hit(weapon.attack(mod: player.level), monster.details.ac)) {
      int dmg = weapon.damage();
      monster.hurt(dmg);

      sb.writeln("You strike the ${monster.htmlName} with your ${weapon.htmlName} for <strong>$dmg</strong> damage.");
    }
    else {
      sb.writeln("You attack the ${monster.htmlName} with your ${weapon.htmlName}, but you miss!");
    }

    sb.writeln();

    if (monster.isDead) {
      sb.writeln("The ${monster.htmlName} dies!");
      sb.writeln();
      sb.write(_rewardPlayer(xp: monster.details.xp, gold: monster.details.gold, items: monster.details.loot()));

      _monster = null;
    }
    else {
      sb.write(_monsterAttack());
    }

    _message(new Message(sb.toString()));

    // if monster died, respawn monsters, etc., but no healing without travel time
    if (monster == null) {
      movePlayer(location, healPlayer: false);
    }
  }

  String _monsterAttack() {
    StringBuffer sb = new StringBuffer();

    if (Attack.hit(monster.details.attackRoll(), player.ac)) {
      int dmg = monster.details.damageRoll();
      player.hurt(dmg);

      sb.writeln("The ${monster.htmlName} strikes you with a ${monster.details.attack.htmlName} for <strong>$dmg</strong> damage.");
    }
    else {
      sb.writeln("The ${monster.htmlName} attacks you with a ${monster.details.attack.htmlName} and misses you!");
    }

    if (player.isDead) {
      sb.writeln();
      sb.writeln("You have died....");

      _monster = null;

      movePlayer(_world.locations[LocationID.home]);
    }

    return sb.toString();
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
            items: loc.quest.hasItem ? [new InventoryItem(loc.quest.item)] : null
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

    if (xp != null && xp > 0) {
      player.gainXP(xp);
      sb.writeln("<strong>XP:</strong> $xp");
    }

    if (gold != null && gold > 0) {
      player.gainGold(gold);
      sb.writeln("<strong>Gold:</strong> $gold");
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

    if (messages.length > MAX_MESSAGES) {
      _messages = messages.skip(messages.length - MAX_MESSAGES).toList();
    }

    // TODO: limit the number of messages we're storing
  }

  Player get player => _player;
  Location get location => _location;
  LiveMonster get monster => _monster;
  List<Message> get messages => _messages;
}