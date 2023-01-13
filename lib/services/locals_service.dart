import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalsService extends ChangeNotifier {
  final String baseUrl = "${BaseService.baseURL}/locals";
  final _supabase = Supabase.instance.client;

  List<LocalModel> locals = [];

  LocalModel? local;

  final List<LocalModel> temps = [];

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  LocalsService() {
    locals.clear();
    temps.clear();
    getAll();
  }

  Future getAll({bool withLoading = true}) async {
    if (locals.isNotEmpty) {
      return;
    }

    if (withLoading) {
      isLoading = true;
    }

    final List<dynamic> res = await _supabase
        .from('locals')
        .select('*,services(*),contacts(*)')
        .eq('services.state', 'active')
        .order('name', ascending: true);

    locals.clear();
    temps.clear();
    notifyListeners();
    for (var item in res) {
      final local = LocalModel.fromMap(item);
      locals.add(local);
      temps.add(local);
    }

    if (withLoading) {
      isLoading = false;
    } else {
      notifyListeners();
    }
  }

  Future search(String text) async {
    if (text.isEmpty) {
      locals = temps;
      isLoading = false;
      return;
    }

    if (text.length < 4) return;

    if (_isLoading) return;

    isLoading = true;

    final List<dynamic> res = await _supabase
        .from('locals')
        .select('*,services(*),contacts(*)')
        .ilike('name', '%$text%')
        .order('name', ascending: true);

    locals.clear();

    for (var item in res) {
      final local = LocalModel.fromMap(item);
      locals.add(local);
    }

    isLoading = false;
  }

  void setLocal(local) {
    this.local = local;
    notifyListeners();
  }
}
