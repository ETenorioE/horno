import 'package:flutter/material.dart';
import 'package:horno/theme/theme.dart';

enum StateNotification { success, error }

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message,
      {StateNotification? state = StateNotification.success}) {
    final backgroundColor = state == StateNotification.success
        ? ColorsApp.colorSecondary
        : ColorsApp.colorError;

    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text(message,
          style: TextStyle(
              color: ColorsApp.colorLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              backgroundColor: backgroundColor)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
