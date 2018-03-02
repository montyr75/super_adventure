import 'quest.dart';

class PlayerQuest {
  final Quest _details;

  bool _isCompleted = false;

  PlayerQuest(this._details);

  void complete() => _isCompleted = true;

  Quest get details => _details;
  bool get isCompleted => _isCompleted;

  String get name => details.name;
  String get htmlName => details.htmlName;
}