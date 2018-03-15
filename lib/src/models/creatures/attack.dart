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

  static bool hit(int attackRoll, int defenderAC) => attackRoll >= defenderAC;

  int attack({int modOverride}) => Roller.rollDie(20) + (modOverride ?? mod);
  int damage() => Roller.rollDiceExp(_dmg);

  RollResult attackVerbose({int modOverride}) => Roller.roll(1, 20, modOverride ?? mod);
  RollResult damageVerbose() => Roller.rollExp(_dmg);

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';
}