import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/index.dart';
import 'package:http/http.dart' as http;

class LocalsService extends ChangeNotifier {
  final String baseUrl = "${BaseService.baseURL}/locals";

  List<LocalModel> locals = [];

  LocalModel? local;

  final List<LocalModel> temps = [];

  final Map<String, String> headers = {
    'apikey': BaseService.apiKey,
    'Authorization': BaseService.authorization
  };

  bool isLoading = false;

  LocalsService() {
    locals.clear();
    temps.clear();
    getAll();
  }

  Future getAll() async {
    isLoading = true;
    notifyListeners();

    final url =
        Uri.parse('$baseUrl?select=*,services(*),contacts(*)&order=name');

    final response = await http.get(url, headers: headers);

    locals.clear();
    temps.clear();

    _processData(response, isCached: false);

    isLoading = false;
    notifyListeners();
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
      locals.clear();
      locals = temps;
      isLoading = false;
      notifyListeners();
      return;
    }

    if (text.length < 4) return;

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final query =
        'select=*,services(*),contacts(*)&name=like.%25$text%25&order=name';

    final url = Uri.parse('$baseUrl?$query');

    final response = await http.get(url, headers: headers);

    locals.clear();
    _processData(response);

    isLoading = false;
    notifyListeners();
  }

  void setLocal(local) {
    this.local = local;
    notifyListeners();
  }
}
