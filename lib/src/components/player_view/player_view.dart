import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/creatures/player.dart';

@Component(selector: 'player-view',
    templateUrl: 'player_view.html',
    directives: const []
)
class PlayerView {
  final LoggerService _log;

  @Input() Player player;

  PlayerView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}