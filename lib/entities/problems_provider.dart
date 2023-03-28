import 'package:flutter/foundation.dart';
import 'dart:math';
import './typedef.dart';
import './cid.dart';
import './problem.dart';
import './user.dart';
import './problem_set.dart';

class ProblemsProvider with ChangeNotifier {
  DateTime? get recent {
    return _recent;
  }

  DateTime? _recent;
  final _problems = <DateTime, MapOfProbs>{};
  final _categoryIds = {
    'Degrees': <String>[],
    'Topics': <String>[],
    'Psets': <String>[],
    'Courses': <String>[],
    'Problems': <String>[],
  };
  Problems _query({
    DateTime? date,
    CID<Problem>? probCid,
    List<String?>? ids,
  }) {
    var temp = <Problem?>[];
    if (date != null) {
      final dateRes = _problems[date] ?? <CID<Problem>, Problem>{};
      if (probCid != null) {
        temp.add(dateRes[probCid]);
      } else {
        if (ids != null && ids.length != _categoryIds.length) {
          return <Problem>[];
        }
        temp += _categoryQuery(ids ?? List.filled(_categoryIds.length, null))
            .map((res) => dateRes[CID.custom(id: res)])
            .toList();
      }
    } else {
      _problems.values.forEach((dateRes) {
        if (probCid != null) {
          temp.add(dateRes[probCid]);
        } else {
          temp += _categoryQuery(ids ?? List.filled(_categoryIds.length, null))
              .map((res) => dateRes[res])
              .toList();
        }
      });
    }
    return _filterNull<Problem>(temp);
  }

  bool _isIdUnique(String probId, Problems oldProbs) {
    return oldProbs.every((prob) {
      return prob.id != probId;
    });
  }

  Strings _generateNewIds(Strings rawIds, Problems oldProbs, int count) {
    final _rawIds = [...rawIds];
    final res = <String>[];
    for (int i = 0; i < count; i++) {
      final newProbId = _rawIds.firstWhere((probId) {
        return _isIdUnique(probId, oldProbs);
      }, orElse: () {
        _rawIds.clear();
        return rawIds[Random().nextInt(rawIds.length)];
      });
      res.add(newProbId);
      _rawIds.remove(newProbId);
    }
    return res;
  }

  Strings _categoryQuery(
    List<String?> ids,
  ) {
    var res = <String>[];
    int count = 0;
    _categoryIds.values.forEach((cl) {
      res = _multiply(res, (ids[count] == null ? cl : [ids[count]!]));
      count++;
    });
    return res;
  }

  Strings _multiply(Strings arr1, Strings arr2) {
    return arr1
        .map((str1) => arr2.map((str2) => '$str1$str2'))
        .expand((res) => res)
        .toList();
  }

  List<T> _filterNull<T>(List<T?> objs) {
    objs.removeWhere((obj) => obj == null);
    return objs.cast<T>();
  }

  Problem _create({
    required List<Map<String, dynamic>> choices,
    required List<String> ids,
    required DateTime date,
    required String question,
    required String solution,
  }) {
    int correctAnswers =
        choices.where((choiceInfo) => choiceInfo['value'] == 1).length;
    late Type type = Type.values.elementAt(Random().nextInt(3));
    while (correctAnswers == 1 && type == Type.multiple) {
      type = Type.values.elementAt(Random().nextInt(3));
    }
    final problem = Problem.create(
      cid: CID<Problem>.custom(id: ids.join()),
      id: ids.length > 0 ? ids[ids.length - 1] : '',
      date: date,
      question: question.trim(),
      solution: solution.trim(),
      //  what other situations are like this?
      choices: [...choices]..shuffle(),
      type: type,
    );
    // print(problem.choices.map((e) => e['content']).toList());
    if (type == Type.enumeration) {
      for (int i = 0; i < correctAnswers; i++) problem.userAnswers.add('');
    }
    return problem;
  }
}

class MockBoard extends ProblemsProvider {
  //  _availAfter and _unlockAfter must be the same unless some modifications on the code are changed
  Future<Duration?> make(DateTime dateToday) async {
    if (_shouldCreate(dateToday)) {
      _current.clear();
      _updateRecent(dateToday);
      final dateProbs = _problems.putIfAbsent(
        _recent!,
        () => <CID<Problem>, Problem>{},
      );
      for (final pset in User.activeDeg.psets) {
        final oldProbs = _query(
          ids: [User.activeDeg.cid.id, pset.cid.id, null, null, null],
        );
        final newIds = _generateNewIds(
          pset.problems.keys.toList(),
          oldProbs,
          100,
        );
        for (final newId in newIds..shuffle()) {
          var probInfo = pset.problems[newId];
          probInfo = probInfo ?? <String, dynamic>{};
          final ids = [
            User.activeDeg.cid.id,
            pset.cid.id,
            '',
            '',
            newId,
          ];
          var currentProbs = _current.putIfAbsent(pset.cid.id, () {
            return <String, dynamic>{
              'name': pset.name,
              'probs': <CID<Problem>>[],
            };
          })['probs'] as List<CID<Problem>>?;
          currentProbs = currentProbs ?? <CID<Problem>>[];
          final problem = _create(
            ids: ids,
            choices: probInfo['choices'] ?? <Map<String, dynamic>>[],
            date: _recent!,
            question: probInfo['question'] ?? '',
            solution: probInfo['solution'] ?? '',
          );
          int count = 0;
          _categoryIds.values.forEach((categoryIds) {
            categoryIds.contains(ids[count])
                ? null
                : categoryIds.add(ids[count]);
            count++;
          });
          currentProbs.add(problem.cid);
          dateProbs.putIfAbsent(problem.cid, () => problem);
        }
      }
    }
    return _startMockBoardIn(dateToday);
  }

  Map<String, Map<String, dynamic>> get current {
    return {..._current};
  }

  int get duration {
    return _durInDays;
  }

  int get unlockAfter {
    return _unlockAfter;
  }

  final _current = <String, Map<String, dynamic>>{};
  final _durInDays = 1;
  final _unlockAfter = 7;
  final _availAfter = 7;

  Duration? _startMockBoardIn(DateTime dateToday) {
    final dateAvailable = User.joinDate.add(Duration(days: _unlockAfter));
    if (_recent != null && dateToday.difference(_recent!).inDays < _durInDays) {
      return null;
    }
    if (_recent != null || dateToday.isAfter(dateAvailable)) {
      final weeks = dateToday.difference(dateAvailable).inDays ~/ _availAfter;
      return dateAvailable
          .add(Duration(days: 7 * (weeks + 1)))
          .difference(dateToday);
    }
    return dateAvailable.difference(dateToday);
  }

  bool _shouldCreate(DateTime dateToday) {
    return _isScheduled(dateToday) && _notRedundant(dateToday);
  }

  bool _isScheduled(DateTime dateToday) {
    final unlockDate = User.joinDate.add(Duration(days: _unlockAfter));
    if (_isUnlocked(dateToday)) {
      // if (dateToday.difference(unlockDate).inDays < _durInDays) {
      //   return true;
      // }
      return dateToday.difference(unlockDate).inDays % _availAfter < _durInDays;
    }
    return false;
  }

  bool _isUnlocked(DateTime dateToday) {
    return dateToday.isAfter(User.joinDate.add(Duration(days: _unlockAfter)));
  }

  bool _notRedundant(DateTime dateToday) {
    return _recent == null
        ? true
        : _recent!.add(Duration(days: _durInDays)).isBefore(dateToday);
  }

  void _updateRecent(DateTime dateToday) {
    //  assuming _durInDays < _availAfter
    final unlockDate = User.joinDate.add(Duration(days: _unlockAfter));
    final daysToAdd =
        _availAfter * dateToday.difference(unlockDate).inDays ~/ _availAfter;
    _recent = unlockDate.add(Duration(days: daysToAdd));
    // if (dateToday.difference(unlockDate).inDays < _durInDays) {
    //   _recent = unlockDate;
    // } else {
    //   final daysToAdd =
    //       _availAfter * dateToday.difference(unlockDate).inDays ~/ _availAfter;
    //   _recent = unlockDate.add(Duration(days: daysToAdd));
    // }
  }
}

class Daily extends ProblemsProvider {
  Map<String, Map<String, dynamic>> get current {
    return {..._current};
  }

  Problems getCurrent(String topicId) {
    var topicInfo = _current[topicId];
    topicInfo = topicInfo ?? <String, dynamic>{};
    return _filterNull(
        (topicInfo['probs'] as List<CID<Problem>>? ?? <CID<Problem>>[])
            .map((cid) => _problems[_recent]![cid])
            .toList());
  }

  Future<void> make(DateTime dateToday) async {
    if (_shouldCreate(dateToday)) {
      _current.clear();
      _recent = User.joinDate.add(
        Duration(days: dateToday.difference(User.joinDate).inDays),
      );
      final dateProbs = _problems.putIfAbsent(
        _recent!,
        () => <CID<Problem>, Problem>{},
      );
      User.degrees.forEach((deg) {
        _topicsPerSet = deg.psets.length > 5 ? 1 : 2;
        for (final pset in deg.psets) {
          for (final topicId in _getRandomTopics(pset.topics.keys.toList())) {
            final topicInfo = pset.topics[topicId] ?? <String, String>{};
            final oldProbs = _query(
              ids: [
                deg.cid.id,
                pset.cid.id,
                topicInfo['course'],
                topicId,
                null
              ],
            );
            final rawProbs = _getTopicProbs(pset, topicId);
            for (final newId in _generateNewIds(
              rawProbs.keys.toList(),
              oldProbs,
              20,
            )..shuffle()) {
              var probInfo = rawProbs[newId];
              probInfo = probInfo ?? <String, dynamic>{};
              final ids = [
                deg.cid.id,
                pset.cid.id,
                topicInfo['course'] ?? '',
                topicId,
                newId,
              ];
              var currentProbs = _current.putIfAbsent(topicId, () {
                return <String, dynamic>{
                  'name': topicInfo['name'] ?? '',
                  'probs': <CID<Problem>>[],
                };
              })['probs'] as List<CID<Problem>>?;
              currentProbs = currentProbs ?? <CID<Problem>>[];
              final problem = _create(
                  ids: ids,
                  choices: probInfo['choices'] ?? <Map<String, dynamic>>[],
                  date: _recent!,
                  question: probInfo['question'] ?? '',
                  solution: probInfo['solution'] ?? '');
              int count = 0;
              _categoryIds.values.forEach((categoryIds) {
                categoryIds.contains(ids[count])
                    ? null
                    : categoryIds.add(ids[count]);
                count++;
              });
              currentProbs.add(problem.cid);
              dateProbs.putIfAbsent(problem.cid, () => problem);
            }
          }
        }
      });
    }
  }

  final _current = <String, Map<String, dynamic>>{};
  var _topicsPerSet = 0;
  bool _shouldCreate(DateTime dateToday) {
    return _recent == null
        ? true
        : _recent!.add(Duration(days: 1)).isBefore(dateToday);
  }

  List<String> _getRandomTopics(List<String> topics) {
    return topics
      ..shuffle()
      ..sublist(
        0,
        topics.length < _topicsPerSet ? topics.length : _topicsPerSet,
      );
  }

  Map<String, Map<String, dynamic>> _getTopicProbs(
    ProblemSet pset,
    String topicId,
  ) {
    final probIds = pset.topicProbs[topicId] ?? <String>[];
    final res = <String, Map<String, dynamic>>{};
    probIds.forEach((probId) {
      res.putIfAbsent(
        probId,
        () => pset.problems[probId] ?? <String, dynamic>{},
      );
    });
    return res;
  }
}
