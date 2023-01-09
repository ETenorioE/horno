import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalsService extends ChangeNotifier {
  final String baseUrl = "${BaseService.baseURL}/locals";
  final _supabase = Supabase.instance.client;

  List<LocalModel> locals = [];

  LocalModel? local;

  final List<LocalModel> temps = [];

  final Map<String, String> headers = {
    'apikey': BaseService.apiKey,
    'Authorization': BaseService.authorization
  };

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
    if (withLoading) {
      isLoading = true;
    }

    final List<dynamic> res = await _supabase
        .from('locals')
        .select('*,services(*),contacts(*)')
        .order('name');

    locals.clear();
    temps.clear();

    for (var item in res) {
      final local = LocalModel.fromMap(item);
      locals.add(local);
      temps.add(local);
    }

    if (withLoading) {
      isLoading = false;
    }
  }

  void _processData(http.Response response, {bool isCached = false}) {
    final List<dynamic> localsMap = json.decode(response.body);

    for (var element in localsMap) {
      final temp = LocalModel.fromMap(element);
      locals.add(temp);

      if (isCached) {
        temps.add(temp);
      }
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
