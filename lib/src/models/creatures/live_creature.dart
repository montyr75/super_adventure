/// This is a mixin.

import '../../utils/roller.dart';

class LiveCreature {
  int _hp;
  int _maxHP;

  void setMaxHP(int max) => _hp = max;

  void setMaxHPByExp(DiceExpression exp) {
    int hp = Roller.rollDiceExp(exp);
    setMaxHP(hp > 0 ? hp : 1);
  }

  void setMaxHPByFormula(String formula) => setMaxHPByExp(new DiceExpression.fromFormula(formula));

  void heal([int amt]) {
    amt ??= maxHP;

    _hp += amt;

    if (hp > maxHP) {
      _hp = maxHP;
    }
  }

  void hurt(int dmg) {
    _hp -= dmg;

    if (hp < 0) {
      _hp = 0;
    }
  }

  int get hp => _hp;
  int get maxHP => _maxHP;
  bool get isDead => hp <= 0;
}