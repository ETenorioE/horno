import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthBase extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  void handleSetExternalUserId(String userId) {
    OneSignal.shared.setExternalUserId(userId).then((results) {});
  }
}
