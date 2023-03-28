import './problem.dart';
import './degree.dart';
import './cid.dart';
import '../utilities/cfunctions_public.dart';

class ProblemSet with ProblemSetInterface {
  ProblemSet.create({
    required this.cid,
    required this.value,
    required this.fcid,
    required this.date,
    required this.name,
    required this.problems,
    required this.topicProbs,
    required this.courses,
    required this.topics,
    required this.courseTopics,
  });
  final CID<ProblemSet> cid;
  final CID<Degree> fcid;
  final double value;
  final DateTime date;
  final String name;
  final Map<String, Map<String, String>> topics;
  final Map<String, Map<String, dynamic>> courses;
  final Map<String, Map<String, dynamic>> problems;
  final Map<String, List<String>> courseTopics;
  final Map<String, List<String>> topicProbs;
  Future<void> add({
    required String probId,
    required String topicId,
    required Map<String, dynamic> probInfo,
    required DateTime date,
  }) async {
    topicProbs.putIfAbsent(topicId, () => <String>[]).add(probId);
    problems.putIfAbsent(probId, () => probInfo);
  }
}

// class BEP<T> extends ProblemSet<T> {
//   BEP({
//     required CID<BEP> cidPrimary,
//     required String name,
//     required Map<DateTime, Map<CID<Problem>, Problem>> problems,
//     required Institution institution,
//     required this.degree,
//     required this.courses,
//   }) : super(
//           cidPrimary: cidPrimary,
//           name: name,
//           problems: problems,
//         );
//   final Degree degree;
//   final List<Course> courses;
// }

mixin ProblemSetInterface {
  final completedAtDate = <DateTime, bool>{};
  final existingSaltIDs = <String>[];
  bool isCompleted(DateTime date) {
    final _isCompleted = completedAtDate[date];
    return (_isCompleted != null && _isCompleted) ? true : false;
  }

  String get freshSalt {
    return cFuncGenerateUniqueCIDString(
      len: 4,
      cidStrings: existingSaltIDs,
    );
  }

  Future<void> markCompleted(
    DateTime date,
  ) async =>
      completedAtDate[date] = true;

  double getTotalScore(List<Problem> problems) {
    double totalUserScore = 0;
    double totalMaxScore = 0;
    problems.forEach((problem) {
      totalUserScore += problem.getUserScore(problem.choices);
      totalMaxScore += problem.getMaxScore(problem.choices);
    });
    return totalUserScore / totalMaxScore;
  }
}
