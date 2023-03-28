import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userID;

  Future<void> signup(
    String email,
    String password,
  ) async {}
}
