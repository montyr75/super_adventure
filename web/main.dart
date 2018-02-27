import 'dart:html';

import 'package:angular/angular.dart';

import 'package:super_adventure/app_component.dart';
import 'package:super_adventure/src/services/logger_service.dart';

const String APP_NAME = "Super Adventure";
final bool _debugMode = window.location.host.contains('localhost');

final LoggerService _log = new LoggerService(appName: APP_NAME, debugMode: _debugMode);

main() {
  bootstrap(AppComponent, [
    provide(LoggerService, useValue: _log)
  ]);
}
