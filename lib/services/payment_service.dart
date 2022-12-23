import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/base.dart';
import 'package:http/http.dart' as http;

class PaymentService extends ChangeNotifier {
  final String baseUrl = "${BaseService.baseURL}/orders";

  bool isLoading = false;

  Future save(OrderModel order) async {
    Map<String, String> headers = {
      'apikey': BaseService.apiKey,
      'Authorization': BaseService.authorization,
      "Content-Type": "application/json",
      "Prefer": "return=minimal"
    };

    isLoading = true;
    notifyListeners();

    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: headers,
    );
  }
}
