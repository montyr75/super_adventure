import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/message.dart';

import '../../directives/safe_inner_html.dart';
import '../../directives/vu_scroll_down.dart';

@Component(selector: 'messages-view',
    templateUrl: 'messages_view.html',
    styleUrls: ['messages_view.css'],
    directives: [coreDirectives, SafeInnerHtml, VuScrollDown]
)
class MessagesView {
  final LoggerService _log;

  @Input() List<Message> messages;

  MessagesView(LoggerService this._log) {
//    _log.info("$runtimeType()");
  }
}