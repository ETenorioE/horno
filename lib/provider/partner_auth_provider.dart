//creación de Clase
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horno/preferences/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PartnerAuthProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final storage = const FlutterSecureStorage();

  String email = '';
  String password = '';
  String businessName = '';
  String businessAddress = '';
  String businessOfficeHours = '';
  String confirmationPassword = '';
  String? userId;

  //definir carga
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final supabase = Supabase.instance.client;

  Future<String?> createLocal({
    required String name,
    required String address,
    required String officeHours,
  }) async {
    try {
      if (this.userId == null) {
        return 'No se pudo completar....';
      }
      Map<String, dynamic> data = {
        'name': name,
        'address': address,
        'office_hours': officeHours,
        'banner':
            'https://cdn.pixabay.com/photo/2017/02/15/11/05/texture-2068283_960_720.jpg',
        'image':
            'https://cdn.pixabay.com/photo/2019/04/26/07/14/store-4156934_960_720.png',
      };
      final res = await supabase.from('locals').insert(data).select().single();

      Map<String, dynamic> dataProfile = {
        'user_id': this.userId,
        'local_id': res['id'],
        'rol': 'admin',
      };
      final resProfile = await supabase.from('profile').insert(dataProfile);
      storage.write(key: 'token', value: this.userId);
      Preferences.rolApp = 'partner';
      Preferences.localName = name;
      return null;
    } catch (e) {
      print('Error ${e.toString()}');
      return 'No se pudo completar la operación';
    }
  }

  Future<String?> createUser(String email, String password) async {
    try {
      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password);

      // final Session? session = res.session;

      final User? user = res.user;

      if (user != null) {
        print("USER: ${user.id}");
        this.userId = user.id;
        notifyListeners();
        return null;
      } else {
        return 'El usuario ya existe';
      }
    } on AuthException catch (e) {
      return 'El usuario ya existe';
    }
  }

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

  void notifyNext() {
    notifyListeners();
  }
}
