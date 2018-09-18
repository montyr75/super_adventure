import 'dart:async';

import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../services/game.dart';
import '../../models/locations/location.dart';
import '../../models/locations/world_map.dart';

import '../../directives/safe_inner_html.dart';

@Component(selector: 'location-view',
    templateUrl: 'location_view.html',
    styleUrls: ['location_view.css'],
    directives: const [SafeInnerHtml],
    exports: const [Direction]
)
class LocationView {
  final LoggerService _log;
  final Game _game;

  @Input() Location location;

  final StreamController<Location> _onMove = new StreamController.broadcast();
  @Output() Stream<Location> get onMove => _onMove.stream;

  final StreamController _onExplore = new StreamController.broadcast();
  @Output() Stream get onExplore => _onExplore.stream;

  LocationView(LoggerService this._log, Game this._game) {
    _log.info("$runtimeType()");
  }

  void move(Direction dir) {
    Location destination;

    switch (dir) {
      case Direction.north: destination = worldMap.north(location); break;
      case Direction.east: destination = worldMap.east(location); break;
      case Direction.south: destination = worldMap.south(location); break;
      case Direction.west: destination = worldMap.west(location); break;
    }

    _onMove.add(destination);
  }

  void explore() => _onExplore.add(null);

  Game get game => _game;
  WorldMap get worldMap => game.worldMap;
}