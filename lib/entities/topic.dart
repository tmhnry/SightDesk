import 'package:flutter/foundation.dart';
import './course.dart';
import 'cid.dart';

class Topic {
  final CID<Topic> cidPrimary;
  final CID<Course> cidSecondary;
  final DateTime date;
  final String name;
  Topic({
    required this.cidPrimary,
    required this.cidSecondary,
    required this.date,
    required this.name,
  });
  static Future<Topic> create({
    required CID<Course> cidSecondary,
    required String id,
    required DateTime date,
    required String name,
  }) async {
    return TopicCache.add(
      Topic(
        cidPrimary: CID<Topic>.custom(id: id),
        cidSecondary: cidSecondary,
        date: date,
        name: name,
      ),
    );
  }
}

class TopicCache with ChangeNotifier {
  TopicCache._init();
  static final cache = TopicCache._init();
  final _topics = <CID<Topic>, Topic>{};
  static Map<CID<Topic>, Topic> get topics {
    return {...cache._topics};
  }

  static Topic? getTopic(CID<Topic> cid) {
    return topics[cid];
  }

  static Topic add(Topic topic) {
    return cache._topics.putIfAbsent(
      topic.cidPrimary,
      () => topic,
    );
  }
}
