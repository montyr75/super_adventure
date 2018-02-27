import '../../utils/roller.dart';

class Attack {
  final String name;
  final int mod;            // for monsters, this is essentially "to-hit"
  final String dmgFormula;

  DiceExpression _dmg;

  Attack(this.name, this.mod, this.dmgFormula) {
    _dmg = new DiceExpression.fromFormula(dmgFormula);
  }

  int attack() => Roller.rollDie(20) + mod;
  int damage() => Roller.rollDiceExp(_dmg);
}