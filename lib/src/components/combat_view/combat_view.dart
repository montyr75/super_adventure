import 'package:angular/angular.dart';
import 'package:angular_components/material_progress/material_progress.dart';

import '../../services/logger_service.dart';
import '../../services/game.dart';
import '../../models/global.dart';
import '../../models/message.dart';
import '../../models/items/weapon.dart';
import '../../utils/utils.dart';

import '../../directives/safe_inner_html.dart';

@Component(selector: 'combat-view',
    templateUrl: 'combat_view.html',
    directives: const [CORE_DIRECTIVES, SafeInnerHtml, MaterialProgressComponent],
    exports: const [percent]
)
class CombatView {
  final LoggerService _log;
  final Game _game;

  bool inCombat = false;

  Message _message;

  CombatView(LoggerService this._log, Game this._game) {
    _log.info("$runtimeType()");
  }

  void flee() {
    inCombat = false;
    game.flee();
  }

  void attack(Weapon weapon) {

  }

  Game get game => _game;
  Message get message => _message;

  String get heroImgPath => "$IMAGE_PATH/hero.jpg";
  String get monsterImgPath => game.monster.details.imgPath;
}