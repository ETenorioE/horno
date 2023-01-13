import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/widgets/index.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final Widget? prefix;
  final Widget? suffix;
  final void Function()? onPressed;
  const ButtonWidget(
      {super.key, this.text, this.onPressed, this.prefix, this.suffix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 58,
        child: MaterialButton(
            disabledColor: ColorsApp.colorPrimary,
            color: ColorsApp.colorSecondary,
            onPressed: () => onPressed == null ? null : onPressed!(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20, child: prefix),
                  TitleWidget(text!, color: ColorsApp.colorLight),
                  SizedBox(width: 20, child: suffix),
                ])));
  }
}
