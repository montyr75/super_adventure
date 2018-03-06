import 'item.dart';
import '../../utils/roller.dart';

class HealingPotion extends Item {
  final String hpToHealFormula;
  DiceExpression _hpToHeal;

  HealingPotion(this.hpToHealFormula) : super(ItemID.healingPotion, "Potion of Healing", "Potions of Healing", "potion") {
    _hpToHeal = new DiceExpression.fromFormula(hpToHealFormula);
  }

  int activate() => Roller.rollDiceExp(_hpToHeal);

  DiceExpression get hpToHeal => _hpToHeal;
}