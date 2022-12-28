import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horno/proferences/index.dart';
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
        storage.write(key: 'token', value: user.id);
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
        storage.write(key: 'token', value: user.id);
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
  }
}
