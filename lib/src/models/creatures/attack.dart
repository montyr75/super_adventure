import '../../utils/roller.dart';

class Attack {
  final String name;
  final int attackBonus;
  final String dmgFormula;

  DiceExpression _dmg;

  Attack(this.name, this.attackBonus, this.dmgFormula) {
    _dmg = new DiceExpression.fromFormula(dmgFormula);
  }

  int attack() => Roller.rollDie(20) + attackBonus;
  int damage() => Roller.rollDiceExp(_dmg);
}