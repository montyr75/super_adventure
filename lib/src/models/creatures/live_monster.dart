import 'monster.dart';
import 'live_creature.dart';

class LiveMonster extends Object with LiveCreature {
  static const String NAME_COLOR = "red";

  final Monster _details;

  LiveMonster(this._details) {
    setMaxHPByFormula(details.hpFormula);
    heal();
  }

  Monster get details => _details;

  String get htmlName => '<span style="color: $NAME_COLOR;">${details.name}</span>';
}