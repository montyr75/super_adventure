import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/message.dart';

@Component(selector: 'messages-view',
    templateUrl: 'messages_view.html',
    directives: const [CORE_DIRECTIVES]
)
class MessagesView {
  final LoggerService _log;

  @Input() List<Message> messages;

  MessagesView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}