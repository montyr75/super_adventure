import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/message.dart';

import '../../directives/safe_inner_html.dart';

@Component(selector: 'messages-view',
    templateUrl: 'messages_view.html',
    directives: const [CORE_DIRECTIVES, SafeInnerHtml]
)
class MessagesView {
  final LoggerService _log;

  @Input() List<Message> messages;

  MessagesView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}