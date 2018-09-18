import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/services/logger_service.dart';
import 'src/services/game.dart';
import 'src/models/worlds/tutoria.dart';

import 'src/components/player_view/player_view.dart';
import 'src/components/location_view/location_view.dart';
import 'src/components/messages_view/messages_view.dart';
import 'src/components/combat_view/combat_view.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

const String appName = "Super Adventure";
final bool debugMode = window.location.host.contains('localhost');

LoggerService log = LoggerService(appName: appName, debugMode: debugMode);

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css', 'package:angular_components/app_layout/layout.scss.css'],
  templateUrl: 'app_component.html',
  directives: [coreDirectives, materialDirectives, PlayerView, LocationView, MessagesView, CombatView],
  providers: [LoggerService, materialProviders, Game]
)
class AppComponent {
  final LoggerService _log;
  final Game _game;

  AppComponent(LoggerService this._log, Game this._game) {
    _log.info("$runtimeType::AppComponent()");

    game.newGame(Tutoria());
  }

  Game get game => _game;
}
