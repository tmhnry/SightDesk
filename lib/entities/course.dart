import 'package:flutter/foundation.dart';
import './branch.dart';
import './cid.dart';
import './typedef.dart';

class Course {
  final CID<Course> cid;
  final CID<Field> fcid;
  final Topics topics;
  final int courseUnits;
  final DateTime date;
  final String name;
  Course.create({
    required this.cid,
    required this.fcid,
    required this.courseUnits,
    required this.date,
    required this.name,
    required this.topics,
  });
}

class CourseCache with ChangeNotifier {
  CourseCache._init();
  final _courses = <CID<Course>, Course>{};
  final cache = CourseCache._init();
  Map<CID<Course>, Course> get courses {
    return {..._courses};
  }

  Course? getCourse(CID<Course> cid) {
    return courses[cid];
  }

  Course add(Course course) {
    return _courses.putIfAbsent(
      course.cid,
      () => course,
    );
  }
}
