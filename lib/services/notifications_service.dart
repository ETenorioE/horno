import 'package:flutter/material.dart';
import 'package:horno/theme/theme.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      backgroundColor: ColorsApp.colorSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      content: Text(message,
          style: TextStyle(
              color: ColorsApp.colorLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              backgroundColor: ColorsApp.colorSecondary)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
