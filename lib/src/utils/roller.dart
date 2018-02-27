import "dart:math" as Math;

class Roller {
  static Math.Random _random = new Math.Random(new DateTime.now().millisecondsSinceEpoch);

  Roller();

  /// These return only the total of the roll.

  static int rollDie(int sides) => _random.nextInt(sides) + 1;

  static int rollDice(int qty, int sides, [int mod = 0]) {
    assert(qty > 1 && sides > 1);

    int rollsTotal = 0;

    for (int i = 0; i < qty; i++) {
      rollsTotal += rollDie(sides);
    }

    return rollsTotal + mod;
  }

  static int rollDiceExp(DiceExpression exp) => rollDice(exp.qty, exp.sides, exp.mod);


  /// These return full roll results.

  static RollResult roll(int qty, int sides, [int mod = 0]) => rollExp(new DiceExpression(qty, sides, mod));

  static RollResult rollExp(DiceExpression exp) {
    int finalTotal = 0;
    int rollsTotal = 0;
    List<int> rolls = new List<int>(exp.qty);

    for (int i = 0; i < exp.qty; i++) {
      rolls[i] = rollDie(exp.sides);
      rollsTotal += rolls[i];
    }

    finalTotal = rollsTotal + exp.mod;

    return new RollResult(exp, finalTotal, rollsTotal, rolls);
  }
}

class DiceExpression {
  static const String ERROR = "*Roll Formula Error*";

  final int qty;
  final int sides;
  final int mod;

  DiceExpression(this.qty, this.sides, [this.mod = 0]) {
    assert(qty > 1 && sides > 1);
  }

  factory DiceExpression.fromFormula(String formula) {
    int sides;
    int qty = 0;
    int mod = 0;

    // strip out all spaces and convert to lowercase
    formula = formula.replaceAll(' ', '').toLowerCase();

    /*
    // RegExp broken out
    String re1 = r'(\d+)*';      // multi-digit integer (optional)
    String re2 = r'd';           // "d" (required, but not remembered in the match array)
    String re3 = r'([1-9]\d*)';  // multi-digit integer greater than 0 (required)
    String re4 = r'([-+]\d+)*';  // +/- and multi-digit integer (optional)
    RegExp exp = new RegExp(re1+re2+re3+re4, multiLine: false, caseSensitive: false);
    */

    RegExp exp = new RegExp(r"(\d+)*d([1-9]\d*)([-+]\d+)*", multiLine: false, caseSensitive: false);
    Match matches = exp.firstMatch(formula);

    // if there are no matches, the string is an invalid expression
    if (matches == null) {
      print(ERROR);
      return null;
    }

    // DEBUG
//    if (matches != null) {
//        print("Group Count: ${matches.groupCount}\n");
//        for (int i = 0; i <= matches.groupCount; i++) {
//          print("$i: ${matches[i]}");
//        }
//  	}
//    else {
//      print("No RegExp match!");
//    }

    // process qty (default to 1 if not included or not valid)
    if (matches[1] != null) {
      int qtyInt = int.parse(matches[1]);
      qty = qtyInt > 1 ? qtyInt : 1;
    }
    else {
      qty = 1;
    }

    // process die sides
    sides = int.parse(matches[2]);

    // process modifier
    if (matches[3] != null) {
      String match = matches[3];

      if (match.length > 1) {
        String sign = match[0];
        int modInt = int.parse(match.substring(1, match.length));

        if (sign == "-") {
          modInt *= -1;
        }

        mod = modInt;
      }
    }

    return new DiceExpression(qty, sides, mod);
  }

  @override String toString() =>"${qty}d${sides}${modString}";

  String get modString => (mod == 0) ? "" : " " + (mod > 0 ? "+" : "-") + " " + mod.abs().toString();
}

class RollResult {
  final DiceExpression exp;

  final int finalTotal;
  final int rollsTotal;
  final List<int> rolls;

  RollResult(this.exp, this.finalTotal, this.rollsTotal, this.rolls);

  @override String toString() => "$formulaString = $finalTotal";
  String toHTMLString() => "$formulaString = <b>$finalTotal</b>";

  String get formulaString => "${exp.qty}d${exp.sides} $rolls${exp.modString}";
}