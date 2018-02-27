import 'item.dart';
import '../../utils/roller.dart';

class Weapon extends Item {
  final String dmgFormula;
  DiceExpression _dmg;

  Weapon(ItemID id, String name, String namePlural, this.dmgFormula) : super(id, name, namePlural) {
    _dmg = new DiceExpression.fromFormula(dmgFormula);
  }

  int attack() => Roller.rollDiceExp(dmg);

  DiceExpression get dmg => _dmg;
}