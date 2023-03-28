import 'package:flutter/foundation.dart';
import './degree.dart';
import './typedef.dart';
import './cid.dart';
import './institution.dart';

enum Sex { Male, Female }
const String firstName = 'firstName';
const String middleName = 'middleName';
const String lastName = 'lastName';
const String email = 'email';
const String contactNum = 'contactNum';
const String sex = 'sex';
const String address = 'address';

class User with ChangeNotifier {
  static final User provider = User._init();
  late final Degrees _degrees;
  late final List<CID<Institution>> _instCids;
  late final Sex _sex;
  late final String _username;
  late final DateTime _joinDate;
  late Degree _activeDeg;
  User._init();
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _email = '';
  String _address = '';
  String _contactNum = '';
  static Degree get activeDeg => provider._activeDeg;
  static DateTime get joinDate => provider._joinDate;
  static Degrees get degrees => provider._degrees;
  static getInfo(String helper) {
    if (helper == firstName) {
      return provider._firstName;
    }
    if (helper == middleName) {
      return provider._middleName;
    }
    if (helper == lastName) {
      return provider._lastName;
    }
    if (helper == address) {
      return provider._address;
    }
    if (helper == email) {
      return provider._email;
    }
    if (helper == contactNum) {
      return provider._contactNum;
    }
  }

  static Future<void> create({
    required String username,
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String address,
    required String contactNum,
    required Sex sex,
    required Degree activeDeg,
    required List<CID<Institution>> instCids,
    required List<Degree> degrees,
  }) async {
    provider._username = username;
    provider._firstName = firstName;
    provider._middleName = middleName;
    provider._lastName = lastName;
    provider._email = email;
    provider._activeDeg = activeDeg;
    provider._address = address;
    provider._contactNum = contactNum;
    provider._sex = sex;
    provider._instCids = instCids;
    provider._degrees = degrees;
    provider._joinDate = DateTime.now();
  }
}
