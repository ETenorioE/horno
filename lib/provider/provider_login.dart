//creación de Clase
import 'package:flutter/material.dart';

class ProviderLogin extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
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
}
