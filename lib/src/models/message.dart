class Message {
  final String _text;

  Message(this._text);

  String get text => _text;
  String get htmlText => _text.replaceAll('\n', '<br>');
}