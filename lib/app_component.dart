import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/services/logger_service.dart';
import 'src/services/game.dart';
import 'src/models/worlds/tutoria.dart';

import 'src/components/player_view/player_view.dart';
import 'src/components/location_view/location_view.dart';
import 'src/components/messages_view/messages_view.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css', 'package:angular_components/app_layout/layout.scss.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, PlayerView, LocationView, MessagesView],
  providers: const [materialProviders]
)
class AppComponent {
  final LoggerService _log;

  Game _game;

  AppComponent(LoggerService this._log) {
    _log.info("$runtimeType::AppComponent()");

    _game = new Game(_log);
    game.newGame(new Tutoria());
  }

  Game get game => _game;
}
