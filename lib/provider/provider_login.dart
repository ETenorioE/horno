import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/provider/auth_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderLogin extends AuthBase {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  String email = '';
  String password = '';
  String confirmationPassword = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool isSamePassword() {
    return password == confirmationPassword;
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
        handleSetExternalUserId(user.id);
        return null;
      } else {
        return 'Datos incorrectos';
      }
    } on AuthException catch (_) {
      return 'Datos incorrectos';
    }
  }
}
