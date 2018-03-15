import 'package:angular/angular.dart';
import 'package:angular_components/material_progress/material_progress.dart';

import '../../services/logger_service.dart';
import '../../services/game.dart';
import '../../models/global.dart';
import '../../utils/utils.dart';
import '../messages_view/messages_view.dart';

import '../../directives/safe_inner_html.dart';

@Component(selector: 'combat-view',
    templateUrl: 'combat_view.html',
    directives: const [CORE_DIRECTIVES, SafeInnerHtml, MaterialProgressComponent, MessagesView],
    exports: const [percent]
)
class CombatView {
  final LoggerService _log;
  final Game _game;

  bool inCombat = false;

  CombatView(LoggerService this._log, Game this._game) {
    _log.info("$runtimeType()");
  }

  void startCombat() {
    inCombat = true;
    game.clearMessages();
  }

  void endCombat() {
    game.clearMessages();
    game.endCombat();
  }

  Game get game => _game;

  String get heroImgPath => "$IMAGE_PATH/hero.jpg";
  String get monsterImgPath => game.monster.details.imgPath;
}