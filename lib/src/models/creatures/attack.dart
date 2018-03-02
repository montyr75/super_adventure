import '../../utils/roller.dart';

class Attack {
  static const String NAME_COLOR = "red";

  final String name;
  final int mod;            // for monsters, this is essentially "to-hit"
  final String dmgFormula;

  DiceExpression _dmg;

  Attack(this.name, this.mod, this.dmgFormula) {
    _dmg = new DiceExpression.fromFormula(dmgFormula);
  }

  static bool hit(int attackRoll, int defenderAC) {
    print("Attack: $attackRoll  AC: $defenderAC");
    return attackRoll >= defenderAC;
  }

  int attack() => Roller.rollDie(20) + mod;
  int damage() => Roller.rollDiceExp(_dmg);

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';
}