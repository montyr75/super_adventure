import 'dart:html' show Element, NodeTreeSanitizer;

import 'package:angular/angular.dart' show Directive, Input, OnChanges, SimpleChange;

@Directive(selector: '[safeInnerHtml]')
class SafeInnerHtml implements OnChanges {
  Element _el;
  SafeInnerHtml(this._el);

  @Input()
  String safeInnerHtml;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    _el.setInnerHtml(this.safeInnerHtml, treeSanitizer: NodeTreeSanitizer.trusted);
  }
}