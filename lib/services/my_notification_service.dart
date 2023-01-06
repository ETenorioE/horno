import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyNotificationService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final supabase = Supabase.instance.client;
  List<MyNotificationModel> notifications = [];

  MyNotificationService() {
    getMyNotifications(Preferences.userId);
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future getMyNotifications(String userId) async {
    final List<dynamic> res = await supabase
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('id', ascending: false);

    notifications.clear();

    for (var element in res) {
      final temp = MyNotificationModel.fromJson(element);
      notifications.add(temp);
    }
    notifyListeners();
  }
}
