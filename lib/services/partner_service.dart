import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PartnerService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final supabase = Supabase.instance.client;
  String? businessName;
  LocalModel? local;
  bool isLoading = false;

  PartnerService() {}

  Future findLocalById() async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await supabase
          .from('locals')
          .select()
          .eq('id', Preferences.localId)
          .limit(1)
          .single();
      local = LocalModel.fromMap(res);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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

        final localId = await _findProfileByUser(user.id);

        if (localId == null) {
          return 'Dato incorrectos';
        }

        Preferences.localId = localId;

        storage.write(key: 'token', value: user.id);
        _handleSetExternalUserId(user.id);
        Preferences.rolApp = 'partner';
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

  Future<int?> _findProfileByUser(String userId) async {
    try {
      final res = await supabase
          .from('profile')
          .select('local_id, locals(name,image)')
          .eq('user_id', userId)
          .limit(1)
          .single();

      businessName = res['locals']['name'];
      Preferences.localImage = res['locals']['image'];
      Preferences.localName = businessName!;
      notifyListeners();
      return res['local_id'];
    } catch (_) {
      return null;
    }
  }
}
