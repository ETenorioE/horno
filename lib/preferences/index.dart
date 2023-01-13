import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _email = '';
  static String _userId = '';
  static String _rolApp = 'client';
  static int _localId = 0;
  static String _localName = '';
  static int _orderId = 0;

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

  static String get userId {
    return _prefs.getString('userId') ?? _userId;
  }

  static set userId(String userId) {
    _userId = userId;
    _prefs.setString('userId', userId);
  }

  static int get localId {
    return _prefs.getInt('localId') ?? _localId;
  }

  static set localId(int localId) {
    _localId = localId;
    _prefs.setInt('localId', localId);
  }

  static int get orderId {
    return _prefs.getInt('orderId') ?? _orderId;
  }

  static set orderId(int orderId) {
    _orderId = orderId;
    _prefs.setInt('orderId', orderId);
  }

  static String get localName {
    return _prefs.getString('localName') ?? _localName;
  }

  static set localName(String localName) {
    _localName = localName;
    _prefs.setString('localName', localName);
  }

  static String get emailShort {
    if (email == '') return '';

    final endCharacters = email.indexOf('@');

    return email.substring(0, endCharacters);
  }

  static String get rolApp {
    return _prefs.getString('rolApp') ?? _rolApp;
  }

  static set rolApp(String rolApp) {
    _rolApp = rolApp;
    _prefs.setString('rolApp', rolApp);
  }
}
