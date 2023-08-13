import 'package:flutter/material.dart';

import '../Pages/LogInPage/AuthMethod.dart';
import '../Pages/LogInPage/userData.dart';
class Userdata with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await AuthMethod().GetUserDetails();
    _userData = userData;
    notifyListeners();
  }
}
