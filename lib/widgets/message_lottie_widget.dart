import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';
import 'package:lottie/lottie.dart';

class MessageLottie extends StatelessWidget {
  final String message;
  final String asset;
  Color _colorText = ColorsApp.colorSecondary;
  MessageLottie(
      {super.key,
      required this.message,
      required this.asset,
      Color? colorText}) {
    _colorText = colorText ?? _colorText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextWidget(message, color: _colorText),
      Lottie.asset('assets/lottie/$asset.json'),
    ]);
  }
}
