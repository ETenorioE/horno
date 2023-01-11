import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  final supabase = Supabase.instance.client;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    notifyListeners();
    _isLoading = value;
  }
}
