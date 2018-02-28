import 'dart:async';

import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/location.dart';

import '../../directives/safe_inner_html.dart';

@Component(selector: 'location-view',
    templateUrl: 'location_view.html',
    directives: const [SafeInnerHtml],
    exports: const [Direction]
)
class LocationView {
  final LoggerService _log;

  @Input() Location location;

  final StreamController<Location> _onMove = new StreamController.broadcast();
  @Output() Stream<Location> get onMove => _onMove.stream;

  LocationView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void move(Direction dir) => _onMove.add(location.destinations[dir]);
}