import './cid.dart';
import './institution.dart';
import './course.dart';
import './typedef.dart';

class Branch {
  final CID<Branch> cid;
  final CID<Institution> fcid;
  final DateTime date;
  final String name;
  Branch.create({
    required this.cid,
    required this.fcid,
    required this.date,
    required this.name,
  });
}

class Field {
  final CID<Field> cid;
  final CID<Branch> fcid;
  final DateTime date;
  final List<Course> courses;
  final String name;
  Field.create({
    required this.cid,
    required this.fcid,
    required this.date,
    required this.name,
    required this.courses,
  });
}

// class Branches with ChangeNotifier {
//   static final Branches instance = Branches._init();
//   Branches._init();
//   Map<CID, Branch> _branches = {};
//   static Map<CID, Branch> get branches => {...instance._branches};
//   static Future<Branch> createBranch(
//     String name, {
//     CID? primaryCID,
//   }) async {
//     CID cidPrimary = primaryCID ??
//         CID(
//           cidLength: branches.isEmpty ? 2 : null,
//           cidStrings: cFuncGetCIDStrings(branches.keys.toList()),
//         );
//     final Branch branch = Branch(
//       cidPrimary: cidPrimary,
//       name: name,
//     );
//     // await dbCreateBranch(branch);
//     instance._branches.addEntries(
//       {
//         MapEntry(cidPrimary, branch),
//       },
//     );
//     // instance.notifyListeners();
//     return branch;
//   }

//   static Branch branchFromname(String name) => branches.values.firstWhere(
//         (branch) => branch.name == name,
//       );
// }

// class Fields with ChangeNotifier {
//   static final Fields instance = Fields._init();
//   Fields._init();
//   Map<CID, Field> _fields = {};
//   static Map<CID, Field> get fields => {...instance._fields};
//   static Future<Field> createField(
//     String name, {
//     required Branch fieldBranch,
//     CID? primaryCID,
//   }) async {
//     CID fieldId = primaryCID ??
//         CID(
//           cidLength: fields.isEmpty ? 2 : null,
//           cidStrings: cFuncGetCIDStrings(fields.keys.toList()),
//         );

//     final Field field = Field(
//       fieldId: fieldId,
//       fieldBranch: fieldBranch,
//       name: name,
//     );

//     // await dbCreateBranch(branch);
//     instance._fields.addEntries(
//       {
//         MapEntry(fieldId, field),
//       },
//     );
//     // instance.notifyListeners();
//     return field;
//   }

//   static Field fieldFromname(String name) => fields.values.firstWhere(
//         (field) => field.name == name,
//       );
// }

// class Courses with ChangeNotifier {
//   static final Courses instance = Courses._init();
//   Courses._init();
//   Map<CID, Course> _courses = {};
//   static Map<CID, Course> get courses => {...instance._courses};
//   static Future<Course> createCourse({
//     required String name,
//     required Field courseField,
//     required int courseUnits,
//     CID? primaryCID,
//   }) async {
//     CID courseId = primaryCID ??
//         CID(
//           cidLength: courses.isEmpty ? 2 : null,
//           cidStrings: cFuncGetCIDStrings(courses.keys.toList()),
//         );
//     final Course course = Course(
//       courseId: courseId,
//       courseField: courseField,
//       name: name,
//       courseUnits: courseUnits,
//     );
//     // await dbCreateBranch(branch);
//     instance._courses.addEntries(
//       {
//         MapEntry(courseId, course),
//       },
//     );
//     // instance.notifyListeners();
//     return course;
//   }

//   static Course courseFromname(String name) => courses.values.firstWhere(
//         (course) => course.name == name,
//       );
// }

// class Topics with ChangeNotifier {
//   static final Topics instance = Topics._init();
//   Topics._init();
//   Map<CID, Topic> _topics = {};
//   static Map<CID, Topic> get topics => {...instance._topics};
//   static List<Topic> retrieveTopicsByCourse(Course course) => topics.values
//       .where(
//         (topic) => topic.topicCourse == course,
//       )
//       .toList();
//   static Future<Topic> createTopic(
//     String name, {
//     required Course topicCourse,
//     CID? primaryCID,
//   }) async {
//     CID topicID = primaryCID ??
//         CID(
//           cidLength: topics.isEmpty ? 3 : null,
//           cidStrings: cFuncGetCIDStrings(topics.keys.toList()),
//         );
//     final Topic topic = Topic(
//       topicID: topicID,
//       topicCourse: topicCourse,
//       name: name,
//     );
//     // await dbCreateBranch(branch);
//     instance._topics.addEntries(
//       {
//         MapEntry(topicID, topic),
//       },
//     );
//     // instance.notifyListeners();
//     return topic;
//   }

//   static Topic topicFromname(String name) =>
//       topics.values.firstWhere((topic) => topic.name == name);
// }

// Future<void> initBranches() async {
//   for (Map<String, dynamic> branchMap in rootInstitution[branches]) {
//     int branchIndex = Branches.branches.length;
//     final Branch branch = await Branches.createBranch(
//       branchMap[branch],
//       primaryCID: CID.custom(
//         cidString: branchCIDStrings.elementAt(branchIndex),
//         date: DateTime.now(),
//       ),
//     );
//     print(
//       branch.name,
//     );
//     for (Map<String, dynamic> fieldMap in branchMap[fields]) {
//       int fieldIndex = Fields.fields.length;
//       final Field field = await Fields.createField(
//         fieldMap[field],
//         fieldBranch: Branches.branchFromname(branchMap[branch]),
//         primaryCID: CID.custom(
//           cidString: fieldCIDStrings.elementAt(fieldIndex),
//           date: DateTime.now(),
//         ),
//       );
//       print(
//         field.name,
//       );
//       for (Map<String, dynamic> courseMap in fieldMap[courses]) {
//         int courseIndex = Courses.courses.length;
//         final Course course = await Courses.createCourse(
//           name: courseMap[course],
//           courseField: Fields.fieldFromname(fieldMap[field]),
//           primaryCID: CID.custom(
//             cidString: courseCIDStrings.elementAt(courseIndex),
//             date: DateTime.now(),
//           ),
//           courseUnits: courseMap[units],
//         );
//         print(
//           course.name,
//         );
//         for (String name in courseMap[topics]) {
//           int topicIndex = Topics.topics.length;
//           final Topic topic = await Topics.createTopic(
//             name,
//             topicCourse: Courses.courseFromname(
//               courseMap[course],
//             ),
//             primaryCID: CID.custom(
//               cidString: topicCIDStrings.elementAt(topicIndex),
//               date: DateTime.now(),
//             ),
//           );
//           print(topic.name);
//         }
//       }
//     }
//   }
// }

List<String> branchCIDStrings = [
  'C6',
  '21',
  'AE',
  'A3',
  'B3',
  '0E',
  '45',
  'F3',
  '74',
  '5D',
];

List<String> fieldCIDStrings = [
  '3D',
  '2D',
  '7F',
  '48',
  'EE',
  '19',
  'D3',
  'FB',
  'EB',
  '97',
  '5E',
  '1F',
  '94',
  '38',
  '80',
  'B8',
  '8E',
  '1D',
  '9F',
  '1E',
];

List<String> courseCIDStrings = [
  'D2',
  'E9',
  'EC',
  '35',
  'A1',
  '53',
  'AD',
  '22',
  '87',
  '76',
  '08',
  'EA',
  '6C',
  '52',
  '49',
  '02',
  'AA',
  'E7',
  '91',
  'A2',
  'E0',
  '0B',
  '41',
  '7D',
  '59',
  '04',
  'F7',
  'FE',
  'CE',
  '6A',
  '58',
  '0C',
  'C4',
  '03',
  '07',
  'C8',
  '26',
  '6E',
  '2E',
  '05',
  '23',
  '13',
  'E5',
  '60',
  '72',
  '2B',
  '5F',
  'C5',
  'B4',
  'BE',
  '84',
  'A6',
  '34',
  '54',
  '2A',
  'D7',
  'BC',
  '89',
  '98',
  'F0',
  '69',
  '4D',
  'A9',
  '36',
  'D0',
  '4A',
  'D6',
  '79',
  '30',
  '9E',
];

List<String> topicCIDStrings = [
  'EA6',
  'B26',
  'DAD',
  'BD7',
  '8E3',
  'DD1',
  'EE8',
  '79B',
  '3E4',
  '565',
  'FA5',
  '886',
  'E36',
  'EC9',
  '99A',
  '6DE',
  '4FC',
  'DA4',
  '36C',
  '819',
  '500',
  '577',
  'AF5',
  '459',
  '73B',
  '67B',
  'E14',
  '23E',
  'B54',
  '358',
  '222',
  '808',
  '7D3',
  '19D',
  'A21',
  '32A',
  '6B1',
  '5F5',
  '8C8',
  '5E9',
  'A1D',
  'C1E',
  'E02',
  'A35',
  '8FC',
  'AD5',
  '908',
  '2B4',
  '6D5',
  '3FB',
];
