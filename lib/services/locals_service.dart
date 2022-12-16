import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:http/http.dart' as http;

class LocalsService extends ChangeNotifier {
  final String baseUrl =
      'https://sfqxztleugofniwjptbq.supabase.co/rest/v1/locals';

  List<LocalModel> locals = [];

  final List<LocalModel> temps = [];

  final Map<String, String> headers = {
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmcXh6dGxldWdvZm5pd2pwdGJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzY3MDMsImV4cCI6MTk4NjYxMjcwM30.15cjGyHUNkoGCJajMFvM1ngvC3EU5bnK8JsX-7sCnxs',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmcXh6dGxldWdvZm5pd2pwdGJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzY3MDMsImV4cCI6MTk4NjYxMjcwM30.15cjGyHUNkoGCJajMFvM1ngvC3EU5bnK8JsX-7sCnxs'
  };

  bool isLoading = false;

  LocalsService() {
    getAll();
  }

  Future getAll() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl?select=*');

    final response = await http.get(url, headers: headers);

    locals.clear();
    temps.clear();

    _processData(response, isCached: true);

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
      locals = temps;
      isLoading = false;
      notifyListeners();
      return;
    }

    if (text.length < 4) return;

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final query = 'select=*&name=like.%25$text%25&order=name';

    final url = Uri.parse('$baseUrl?$query');

    final response = await http.get(url, headers: headers);

    locals.clear();
    _processData(response);

    isLoading = false;
    notifyListeners();
  }
}
