import 'package:angular/angular.dart';

import 'logger_service.dart';
import '../models/worlds/world.dart';
import '../models/creatures/player.dart';
import '../models/creatures/monster.dart';
import '../models/creatures/attack.dart';
import '../models/items/item.dart';
import '../models/items/inventory_item.dart';
import '../models/items/healing_potion.dart';
import '../models/items/weapon.dart';
import '../models/locations/location.dart';
import '../models/locations/world_map.dart';
import '../models/message.dart';
import '../utils/roller.dart';

@Injectable()
class Game {
  static const MAX_MESSAGES = 20;

  final LoggerService _log;

  World _world;
  WorldMap _worldMap;
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

    // create world map
    _worldMap = new WorldMap.fromLocations(20, _world.locationsList);

    _log.info("$runtimeType::newGame()\n$worldMap");

    // create player
    _player = new Player();

    // start player at home
    movePlayer(_world.locations[LocationID.home]);

    // player needs a weapon
    _message(new Message(_rewardPlayer(items: [new InventoryItem(_world.items[ItemID.rustySword])])));
  }

  void movePlayer(Location loc) {
    // player heals during travel
    player.heal();

    if (!_checkForRequiredItem(loc)) {
      return;
    }

    _location = loc;

    _checkQuests(loc);
  }

  void explore() {
    StringBuffer sb = new StringBuffer("You search the area.");

    LocationMonster lm = location.getMonster();

    if (lm != null) {
      _monster = lm.spawn();
    }
    else {
      sb.write(" You find nothing of interest.");
    }

    _message(new Message(sb.toString()));
  }

  void playerAttack(Weapon weapon) {
    StringBuffer sb = new StringBuffer();

    RollResult attackResult = weapon.attackVerbose(mod: player.attackBonus);

    sb.write("${weapon.htmlName}: ${attackResult.toHTMLString()}");

    if (Attack.hit(attackResult.finalTotal, monster.details.ac)) {
      sb.writeln("&nbsp;&nbsp;<em style='color: red'>Hit!</em>");

      RollResult dmgResult = weapon.damageVerbose();
      monster.hurt(dmgResult.finalTotal);

      sb.writeln("Damage: ${dmgResult.toHTMLString()}");
    }
    else {
      sb.writeln("&nbsp;&nbsp;<em style='color: lime'>Miss!</em>");
    }

    if (monster.isDead) {
      sb.writeln();
      sb.writeln("The ${monster.htmlName} dies!");
      sb.writeln();
      sb.write(_rewardPlayer(xp: monster.details.xp, gold: monster.details.gold, items: monster.loot()));
    }
    else {
      sb.write("<hr style='width: 50%'>");
      sb.write(_monsterAttack());
    }

    _message(new Message(sb.toString()));
  }

  void playerFlee() {
    _message(new Message("You bravely flee from the ${_monster.htmlName}."));
    endCombat();
  }

  void endCombat() {
    _monster = null;
  }

  void playerDies() {
    endCombat();

    movePlayer(_world.locations[LocationID.home]);
  }

  void playerDrinkHealingPotion(InventoryItem potion) {
    int hp = (potion.details as HealingPotion).activate();
    player.heal(hp);
    player.loseItem(potion.details);

    _message(new Message("You consume a ${potion.details.htmlName}, restoring $hp hit points."));
  }

  void clearMessages() => _messages.clear();

  String _monsterAttack() {
    StringBuffer sb = new StringBuffer();

    RollResult attackResult = monster.attackVerbose();

    sb.write("${monster.htmlName} ${monster.details.attack.htmlName}: ${attackResult.toHTMLString()}");

    if (Attack.hit(attackResult.finalTotal, player.ac)) {
      sb.writeln("&nbsp;&nbsp;<em style='color: red'>Hit!</em>");

      RollResult dmgResult = monster.damageVerbose();
      player.hurt(dmgResult.finalTotal);

      sb.writeln("Damage: ${dmgResult.toHTMLString()}");
    }
    else {
      sb.writeln("&nbsp;&nbsp;<em style='color: lime'>Miss!</em>");
    }

    if (player.isDead) {
      sb.writeln();
      sb.writeln("<strong style='color: red'>You have died....</strong>");
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
        sb.writeln("You take on a new quest!");
        sb.writeln();
        sb.write(loc.quest.toHTMLString());

        _message(new Message(sb.toString()));
      }
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
  }

  Player get player => _player;
  Location get location => _location;
  LiveMonster get monster => _monster;
  List<Message> get messages => _messages;
  WorldMap get worldMap => _worldMap;
}