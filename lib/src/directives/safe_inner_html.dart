import 'dart:html' show Element, NodeTreeSanitizer;

import 'package:angular/angular.dart' show Directive, ElementRef, Input, OnChanges, SimpleChange;

@Directive(selector: '[safeInnerHtml]')
class SafeInnerHtml implements OnChanges {
  ElementRef _elRef;
  SafeInnerHtml(this._elRef);

  @Input() String safeInnerHtml;

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    (_elRef.nativeElement as Element).setInnerHtml(this.safeInnerHtml, treeSanitizer: NodeTreeSanitizer.trusted);
  }
}