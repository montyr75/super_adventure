import 'dart:async';

import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/location.dart';

@Component(selector: 'location-view',
    templateUrl: 'location_view.html',
    directives: const []
)
class LocationView {
  final LoggerService _log;

  @Input() Location location;

  final StreamController<Location> _onMove = new StreamController.broadcast();
  @Output() Stream<Location> get onMove => _onMove.stream;

  LocationView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void move(String dir) {
    Location newLoc;

    switch (dir) {
      case 'N': newLoc = location.north; break;
      case 'E': newLoc = location.east; break;
      case 'S': newLoc = location.south; break;
      case 'W': newLoc = location.west; break;
    }

    _onMove.add(newLoc);
  }
}