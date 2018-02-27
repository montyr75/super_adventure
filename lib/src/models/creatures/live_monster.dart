import 'monster.dart';
import 'live_creature.dart';

class LiveMonster extends Object with LiveCreature {
  final Monster _details;

  LiveMonster(this._details) {
    setMaxHPByFormula(details.hpFormula);
  }

  Monster get details => _details;
}