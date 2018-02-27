import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/services/logger_service.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css', 'package:angular_components/app_layout/layout.scss.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives],
  providers: const [materialProviders]
)
class AppComponent {
  final LoggerService _log;

  AppComponent(LoggerService this._log) {
    _log.info("$runtimeType::AppComponent()");
  }
}
