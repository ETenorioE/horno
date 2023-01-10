import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/widgets/index.dart';

class ButtonRoundedWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool? isActive;
  const ButtonRoundedWidget(
    this.text, {
    super.key,
    this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: MaterialButton(
          elevation: 0,
          color: isActive! ? ColorsApp.colorSecondary : ColorsApp.colorLight,
          onPressed: () => onPressed == null ? null : onPressed!(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: ColorsApp.colorSecondary)),
          child: TextWidget(
            text,
            color: isActive! ? ColorsApp.colorLight : ColorsApp.colorSecondary,
          )),
    );
  }
}
