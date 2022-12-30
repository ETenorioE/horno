//creación de Clase
import 'dart:math';

import 'package:flutter/material.dart';

class PartnerAuthProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String businessName = '';
  String businessAddress = '';
  String businessOfficeHours = '';
  String confirmationPassword = '';

  //definir carga
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

  void notifyNext() {
    notifyListeners();
  }
}
