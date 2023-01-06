import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horno/preferences/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final supabase = Supabase.instance.client;

  Future<String?> createUser(String email, String password) async {
    try {
      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password);

      // final Session? session = res.session;

      final User? user = res.user;

      if (user != null) {
        Preferences.email = user.email!;
        Preferences.userId = user.id;
        Preferences.rolApp = 'client';
        storage.write(key: 'token', value: user.id);
        _handleSetExternalUserId(user.id);
        print("USER: ${user.id}");
        return null;
      } else {
        return 'Usuario no creado';
      }
    } on AuthException catch (e) {
      return 'Usuario no creado';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);

      // final Session? session = res.session;

      final User? user = res.user;

      if (user != null) {
        Preferences.email = user.email!;
        Preferences.userId = user.id;
        Preferences.rolApp = 'client';
        storage.write(key: 'token', value: user.id);
        _handleSetExternalUserId(user.id);
        print("USER: ${user.id}");
        return null;
      } else {
        return 'Datos incorrectos';
      }
    } on AuthException catch (e) {
      return 'Datos incorrectos';
    }
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future logout() async {
    Preferences.email = '';
    Preferences.userId = '';
    await supabase.auth.signOut();
    await storage.deleteAll();
    _handleRemoveExternalUserId();
  }

  void _handleSetExternalUserId(String userId) {
    OneSignal.shared.setExternalUserId(userId).then((results) {
      print("External user id set: $results");
    });
  }

  void _handleRemoveExternalUserId() {
    OneSignal.shared.removeExternalUserId().then((results) {
      print("External user id removed: $results");
    });
  }
}
