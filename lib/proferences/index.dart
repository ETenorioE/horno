import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _email = '';
  static String _userId = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString('email', email);
  }

  // name
  static String get userId {
    return _prefs.getString('userId') ?? _userId;
  }

  static set userId(String userId) {
    _userId = userId;
    _prefs.setString('userId', userId);
  }

  static String get emailShort {
    if (email == '') return '';

    final endCharacters = email.indexOf('@');

    return email.substring(0, endCharacters);
  }
}
