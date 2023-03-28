import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import '../layout/problem_set.dart';
import '../entities/problem.dart';
import '../entities/problem_set.dart';
import '../entities/topic.dart';

enum Category { daily, mockBoard }

class AssessmentState with ChangeNotifier {
  //  Assessment Properties
  bool _start = false;
  bool _review = false;
  int _index = 0;
  Category? _category;
  DateTime? date;
  List<Problem> _problems = <Problem>[];
  //  Daily Assessment
  String _topicName = '';
  //  MockBoard Assessment
  ProblemSet? _problemSet;

  void reset() {
    date = null;
    _problemSet = null;
    _start = false;
    _review = false;
    _index = 0;
    _topicName = '';
    _problems.clear();
  }

  Category? get category {
    return _category;
  }

  void update({
    Category? category,
    bool? start,
    bool? review,
    int? index,
    String? topicName,
    List<Problem>? problems,
    ProblemSet? problemSet,
    bool? listen,
  }) {
    _start = start ?? _start;
    _review = review ?? _review;
    _index = index ?? _index;
    _problems = problems ?? _problems;
    _problemSet = problemSet ?? _problemSet;
    _topicName = topicName ?? _topicName;
    _category = category ?? _category;
    if (listen != null && listen) {
      notifyListeners();
    }
  }

  List<Problem> get problems => _problems;
  ProblemSet? get problemSet {
    return _problemSet;
  }

  String get topicName {
    return _topicName;
  }

  bool get review {
    return _review;
  }

  int get index {
    return _index;
  }

  bool get start {
    return _start;
  }

  bool get resume {
    return _problems.any((problem) => problem.isTaken);
  }

  bool get isCompleted {
    final date = this.date;
    final problemSet = _problemSet;
    if (problemSet != null && date != null) {
      return problemSet.isCompleted(date);
    }
    return false;
  }

  String getPsetFig(String psetId) {
    return psetFigures[psetId] ?? '';
  }

  List<Color> getPsetGrads(String psetId) {
    return psetGradients[psetId] ??
        <Color>[
          Color.fromRGBO(255, 255, 255, 1),
          Color.fromRGBO(255, 255, 255, 1),
        ];
  }

  String get score {
    final problemSet = this.problemSet;
    double score = 0;
    if (problemSet != null) {
      if (isCompleted) {
        score = (problemSet.getTotalScore(problems) * 100);
      }
    }
    return score.toStringAsFixed(2);
  }

  List<Topic> get topics {
    final _topics = <Topic>[];
    final problemSet = this.problemSet;
    if (problemSet != null) {
      var dateBody = problemSet.problems[date];
      dateBody = dateBody ?? <String, dynamic>{};
      final allTopics = dateBody.values
          .map(
            (problem) => problem.topic,
          )
          .toList();
      while (allTopics.isNotEmpty) {
        final topic = allTopics[0];
        if (topic != null) {
          _topics.add(topic);
        }
        allTopics.removeWhere((fromAll) => fromAll == topic);
      }
    }
    return _topics;
  }

  void restart() {
    problems.forEach((problem) {
      if (problem.type == Type.unique) {
        problem.update(
          isTaken: false,
          userAnswers: <String>[],
        );
      }
      if (problem.type == Type.enumeration) {
        final originalAnswers = problem.choices
            .where((choiceInfo) => choiceInfo['value'] == 1)
            .map((choiceInfo) => '')
            .toList();
        problem.update(
          isTaken: false,
          userAnswers: originalAnswers,
        );
      }
    });
    update(index: 0);
    notifyListeners();
  }

  double getTimerValue(Duration mockBoardDuration) {
    final date = this.date;
    if (date != null) {
      return date
              .add(mockBoardDuration)
              .difference(DateTime.now())
              .inMicroseconds /
          (mockBoardDuration.inMicroseconds);
    }
    return 0.0;
  }
}
