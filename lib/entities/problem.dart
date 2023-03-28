import './cid.dart';

mixin ProblemInterface {
  var userAnswers = <String>[];
  late final List<Map<String, dynamic>> choices;
  bool isTaken = false;
  double getMaxScore(
    List<Map<String, dynamic>> choices,
  ) {
    double _maxScore = 0;
    for (Map<String, dynamic> c in choices) {
      if (c['value'] == 1) _maxScore++;
    }
    return _maxScore;
  }

  Future<void> update({
    bool? isTaken,
    List<String>? userAnswers,
  }) async {
    this.isTaken = isTaken ?? this.isTaken;
    this.userAnswers = userAnswers ?? this.userAnswers;
  }

  double getUserScore(
    List<Map<String, dynamic>> choices,
  ) {
    final _userAnswers = userAnswers.sublist(0);
    _userAnswers.removeWhere((userAnswer) => userAnswer.isEmpty);
    double _userScore = 0;
    for (Map<String, dynamic> c in choices) {
      if (c['value'] == 1) {
        if (_userAnswers.contains(c['content'])) {
          _userScore++;
          _userAnswers.remove(c['content']);
        }
      }
    }
    _userScore = _userScore - _userAnswers.length;
    return _userScore < 0 ? 0 : _userScore;
  }
}

enum Type {
  unique,
  multiple,
  enumeration,
}

class Problem with ProblemInterface {
  Problem.create({
    required this.choices,
    required this.cid,
    required this.date,
    required this.type,
    required this.question,
    required this.solution,
    required this.id,
  });
  final List<Map<String, dynamic>> choices;
  final Type type;
  final String id;
  final CID<Problem> cid;
  final DateTime date;
  final String question;
  final String solution;
}
