import 'item.dart';
import '../creatures/attack.dart';

class Weapon extends Item {
  Attack _attack;

  Weapon(ItemID id, String name, String namePlural, String dmgFormula) : super(id, name, namePlural, 'weapon') {
    // a player's attack modifier changes as he progresses or with circumstances, so don't embed one in the Attack object
    _attack = new Attack(name, 0, dmgFormula);
  }

  int attack({int mod = 0}) => _attack.attack() + mod;
  int damage() => _attack.damage();

  String get dmgFormula => _attack.dmgFormula;
}