import 'package:flutter/foundation.dart';
import 'package:sightdesk_new/data/helpers.dart';
import '../data/pset_01.dart';
import '../data/pset_02.dart';
import '../data/pset_03.dart';
import '../data/root_degrees.dart' as rd;
import '../data/root_data.dart' as ri;
import '../data/root_psets.dart' as rps;
import '../entities/user.dart';
import '../entities/typedef.dart';
import '../entities/degree.dart';
import '../entities/cid.dart';
import '../entities/problem_set.dart';
import '../entities/institution.dart';

class AccountSetupState with ChangeNotifier {
  String _sex = 'Male';
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _email = '';
  String _contactNum = '';
  String _address = '';
  Strings _instIds = <String>[];
  Strings _degIds = <String>[];
  int _index = 0;

  List<T> _filterNull<T>(List<T?> objs) {
    objs.removeWhere((obj) => obj == null);
    return objs.cast<T>();
  }

  int get index {
    return _index;
  }

  void update({
    int? index,
    bool? listen,
    String? label,
    Strings? val,
  }) {
    _index = index ?? _index;
    if (val != null && label != null) {
      if (label == 'Degree') {
        _degIds = val;
      } else if (label == 'Institution') {
        _instIds = val;
      } else {
        _updateInfo(label, val[0]);
      }
    }
    if (listen != null && listen) {
      notifyListeners();
    }
  }

  void _updateInfo(String label, String val) {
    if (label == 'First Name') {
      _firstName = val;
    }
    if (label == 'Middle Name') {
      _middleName = val;
    }
    if (label == 'Last Name') {
      _lastName = val;
    }
    if (label == 'Email Address') {
      _email = val;
    }
    if (label == 'Contact Number') {
      _contactNum = val;
    }
    if (label == 'Address') {
      _address = val;
    }
    if (label == 'Sex') {
      _sex = val;
    }
  }

  String getInitialVal(String label) {
    if (label == 'First Name') {
      return _firstName;
    }
    if (label == 'Middle Name') {
      return _middleName;
    }
    if (label == 'Last Name') {
      return _lastName;
    }
    if (label == 'Email Address') {
      return _email;
    }
    if (label == 'Sex') {
      return _sex;
    }
    if (label == 'Contact Number') {
      return _contactNum;
    }
    if (label == 'Address') {
      return _address;
    }
    if (label == 'Institution' && _instIds.isNotEmpty) {
      return _instIds[0];
    }
    if (label == 'Degree' && _degIds.isNotEmpty) {
      return _degIds[0];
    }
    return '';
  }

  Map<String, Map<String, dynamic>> _createPsetProbs(
    Map<String, List<String>> topicProbs,
  ) {
    final res = <String, Map<String, dynamic>>{};
    topicProbs.values.forEach((probs) {
      probs.forEach((probId) {
        var probInfo = pset_01[probId] ?? <String, dynamic>{};
        if (probInfo.isEmpty) {
          probInfo = pset_02[probId] ?? probInfo;
        }
        if (probInfo.isEmpty) {
          probInfo = pset_03[probId] ?? probInfo;
        }
        if (probInfo.isNotEmpty) {
          res.putIfAbsent(probId, () => probInfo);
        }
      });
    });
    return res;
  }

  Map<String, Map<String, String>> _createPsetTopics(
    Map<String, Map<String, String>> psetCourses,
  ) {
    final res = <String, Map<String, String>>{};
    psetCourses.keys.forEach((courseId) {
      var courseTopics = rps.courseTopics[courseId];
      courseTopics = courseTopics ?? <String, Map<String, String>>{};
      courseTopics = courseTopics.map((topicId, topicInfo) {
        return MapEntry(
          topicId,
          topicInfo..putIfAbsent('course', () => courseId),
        );
      });
      res.addAll(courseTopics);
    });
    return res;
  }

  Map<String, List<String>> _createCourseTopics(
    Map<String, Map<String, String>> psetCourses,
  ) {
    return psetCourses.map((courseId, courseInfo) {
      var courseTopics = rps.courseTopics[courseId];
      courseTopics = courseTopics ?? <String, Map<String, String>>{};
      return MapEntry(courseId, courseTopics.keys.toList());
    });
  }

  ProblemSets _createDegPsetObjs(
    Map<String, Map<String, Object>> degPsets,
    String degId,
    DateTime date,
  ) {
    final res = <ProblemSet>[];
    degPsets.forEach((psetId, psetInfo) {
      var psetCourses = rps.psetCourses[psetId];
      psetCourses = psetCourses ?? <String, Map<String, String>>{};
      final psetTopics = _createPsetTopics(psetCourses);
      final topicProbs = psetTopics.map(
        (topicId, _) {
          return MapEntry(topicId, rps.topicProblems[topicId] ?? <String>[]);
        },
      );
      res.add(ProblemSet.create(
        fcid: CID<Degree>.custom(id: degId),
        cid: CID<ProblemSet>.custom(id: psetId),
        value: psetInfo['value'] as double? ?? 0.0,
        date: date,
        name: psetInfo['name'] as String? ?? '',
        courseTopics: _createCourseTopics(psetCourses),
        problems: _createPsetProbs(topicProbs),
        topics: psetTopics,
        courses: psetCourses,
        topicProbs: topicProbs,
      ));
    });
    return res;
  }

  Degrees _createDegObjs({
    required CID<Institution> instCid,
    required DateTime date,
    required Map<String, Map<String, String>> instDegs,
  }) {
    return _filterNull<Degree>(_degIds.map((degId) {
      var degPsets = rps.psets[degId];
      degPsets = degPsets ?? <String, Map<String, Object>>{};
      var degInfo = instDegs[degId];
      degInfo = degInfo ?? <String, String>{};
      return Degree(
        cid: CID<Degree>.custom(id: degId),
        fcid: instCid,
        date: date,
        name: degInfo['name'] ?? '',
        psets: _createDegPsetObjs(degPsets, degId, date),
      );
    }).toList());
  }

  Future<void> complete() async {
    for (final instId in _instIds) {
      var instDegs = rd.degrees[instId];
      instDegs = instDegs ?? <String, Map<String, String>>{};
      var instInfo = ri.institutions[instId];
      instInfo = instInfo ?? <String, String>{};
      final degrees = _createDegObjs(
        instCid: CID<Institution>.custom(id: instId),
        date: DateTime.parse(
          instInfo['date'] ?? DateTime.now().toIso8601String(),
        ),
        instDegs: instDegs,
      );
      await User.create(
        username: _email,
        firstName: _firstName,
        middleName: _middleName,
        lastName: _lastName,
        email: _email,
        address: _address,
        contactNum: _contactNum,
        sex: _sex == 'Male' ? Sex.Male : Sex.Female,
        activeDeg: degrees[0],
        instCids: _instIds.map((id) {
          return CID<Institution>.custom(id: id);
        }).toList(),
        degrees: degrees,
      );
    }
  }
}
