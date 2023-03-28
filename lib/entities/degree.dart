import 'package:flutter/foundation.dart';
import './cid.dart';
import './institution.dart';
import './course.dart';
import './problem_set.dart';

class Degree with DegreeCourseInterface {
  final CID<Degree> cid;
  final CID<Institution> fcid;
  final DateTime date;
  final String name;
  final List<ProblemSet> psets;
  Degree.create({
    required this.name,
    required this.date,
    required this.psets,
    required this.fcid,
    required this.cid,
  });
  Degree({
    required this.cid,
    required this.fcid,
    required this.date,
    required this.name,
    required this.psets,
  });
}

class DegreeCache with ChangeNotifier {
  DegreeCache._init();
  final _degrees = <CID<Degree>, Degree>{};
  Map<CID<Degree>, Degree> get degrees {
    return {..._degrees};
  }

  Degree? getDegree(CID<Degree> cid) {
    return _degrees[cid];
  }

  Degree add(Degree degree) {
    return _degrees.putIfAbsent(
      degree.cid,
      () => degree,
    );
  }
}

mixin DegreeCourseInterface {
  var courseDetails = <Course, Map<String, dynamic>>{};
  bool isActive = false;
}

// class Degrees with ChangeNotifier {
//   static final Degrees instance = Degrees._init();
//   Degrees._init();
//   Map<CID, Degree> _degrees = {};
//   static Map<CID, Degree> get degrees => {...instance._degrees};
//   static Degree get activeDegree =>
//       degrees.values.firstWhere((degree) => degree.isActive);
//   static Future<Degree> createDegree({
//     required Institution institution,
//     required String name,
//     required List<Map<String, dynamic>> degreeCourseMapList,
//     CID? primaryCID,
//     List<CID>? primaryCIDList,
//   }) async {
//     CID cidPrimary = primaryCID ??
//         CID(
//           cidLength: degrees.isEmpty ? 2 : null,
//           cidStrings: cFuncGetCIDStrings(degrees.keys.toList()),
//         );
//     List<DegreeCourse> degreeCourses = [];
//     for (Map<String, dynamic> degreeCourseMap in degreeCourseMapList) {
//       final DegreeCourse degreeCourse = await DegreeCourses.createDegreeCourse(
//         cidPrimary: cidPrimary,
//         course: Courses.courseFromCourseName(
//           degreeCourseMap[JSONNames.course],
//         ),
//         yearLevel: degreeCourseMap[JSONNames.level],
//         academicTerm: degreeCourseMap[JSONNames.term],
//         primaryCID: primaryCIDList == null
//             ? null
//             : primaryCIDList.elementAt(
//                 degreeCourseMapList.indexOf(degreeCourseMap),
//               ),
//       );
//       degreeCourses.add(degreeCourse);
//     }
//     final Degree degree = Degree(
//       institution: institution,
//       cidPrimary: cidPrimary,
//       name: name,
//       degreeCourses: degreeCourses,
//       isActive: false,
//     );
//     // await dbCreateDegree(degree);
//     instance._degrees.addEntries(
//       {
//         MapEntry(cidPrimary, degree),
//       },
//     );
//     return degree;
//   }

//   static Degree degreeFromDegreeName(String name) => degrees.values.firstWhere(
//         (degree) => degree.name == name,
//       );
// }

// class DegreeCourses with ChangeNotifier {
//   static final DegreeCourses instance = DegreeCourses._init();
//   DegreeCourses._init();
//   Map<CID, DegreeCourse> _degreeCourses = {};
//   static Map<CID, DegreeCourse> get degreeCourses =>
//       {...instance._degreeCourses};
//   static Future<DegreeCourse> createDegreeCourse({
//     required CID cidPrimary,
//     required Course course,
//     required YearLevel yearLevel,
//     required AcademicTerm academicTerm,
//     CID? primaryCID,
//   }) async {
//     CID degreeCourseID = primaryCID ??
//         CID(
//           cidLength: degreeCourses.isEmpty ? 3 : null,
//           cidStrings: cFuncGetCIDStrings(degreeCourses.keys.toList()),
//         );
//     final DegreeCourse degreeCourse = DegreeCourse(
//       cidPrimary: cidPrimary,
//       degreeCourseID: degreeCourseID,
//       course: course,
//       yearLevel: yearLevel,
//       academicTerm: academicTerm,
//     );
//     // await dbCreateDegreeSubject(degreeCourse);
//     instance._degreeCourses.addEntries(
//       {
//         MapEntry(
//           degreeCourseID,
//           degreeCourse,
//         )
//       },
//     );
//     return degreeCourse;
//   }
// }

// class BEPs with ChangeNotifier {
//   static final BEPs instance = BEPs._init();
//   BEPs._init();
//   Map<CID, BEP> _beps = {};
//   static Map<CID, BEP> get beps => {...instance._beps};
//   static List<BEP> retrieveBEPsByDegree(Degree degree) =>
//       beps.values.where((bep) => bep.bepDegree == degree).toList();
//   static Future<BEP> createBEP({
//     required Institution bepInstitution,
//     required Degree bepDegree,
//     required String bepName,
//     required List<Course> bepCourses,
//     CID? primaryCID,
//   }) async {
//     CID bepID = primaryCID ??
//         CID(
//           cidLength: beps.isEmpty ? 3 : null,
//           cidStrings: cFuncGetCIDStrings(beps.keys.toList()),
//         );
//     final BEP bep = BEP(
//       bepInstitution: bepInstitution,
//       bepID: bepID,
//       bepName: bepName,
//       bepDegree: bepDegree,
//       bepCourses: bepCourses,
//     );
//     // await dbCreateBEP(bep);
//     instance._beps.addEntries(
//       {
//         MapEntry(bepID, bep),
//       },
//     );
//     return bep;
//   }
// }

// Future<void> initBEPs() async {
//   for (Map<String, dynamic> bepMap in rootInstitution[JSONNames.beps]) {
//     int bepIndex = BEPs.beps.length;
//     final courseNames = bepMap[JSONNames.courses] as List<String>;
//     await BEPs.createBEP(
//       bepInstitution: Institutions.institutionFromInstitutionName(
//         rootInstitution[JSONNames.institution],
//       ),
//       bepDegree: Degrees.degreeFromDegreeName(bepMap[JSONNames.degree]),
//       bepName: bepMap[JSONNames.bep],
//       bepCourses: courseNames
//           .map(
//             (courseName) => Courses.courseFromCourseName(courseName),
//           )
//           .toList(),
//       primaryCID: CID.custom(
//         cidString: bepCIDStrings.elementAt(bepIndex),
//         cidDate: DateTime.now(),
//       ),
//     );
//   }
// }

// Future<void> initDegrees() async {
//   for (Map<String, dynamic> degreeMap in rootInstitution[JSONNames.degrees]) {
//     int degreeIndex = Degrees.degrees.length;
//     await Degrees.createDegree(
//       institution: Institutions.institutionFromInstitutionName(
//           rootInstitution[JSONNames.institution]),
//       name: degreeMap[JSONNames.degree],
//       degreeCourseMapList: degreeMap[JSONNames.degree_courses],
//       primaryCID: CID.custom(
//         cidString: degreeCIDStrings.elementAt(degreeIndex),
//         cidDate: DateTime.now(),
//       ),
//       primaryCIDList: degreeCourseCIDStrings
//           .map(
//             (degreeCourseCIDString) => CID.custom(
//               cidString: degreeCourseCIDString,
//               cidDate: DateTime.now(),
//             ),
//           )
//           .toList(),
//     );
//   }
// }
