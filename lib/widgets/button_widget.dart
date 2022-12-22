import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/widgets/index.dart';

class ButtonWidget extends StatelessWidget {
  final Widget? child;
  final void Function() onPressed;
  const ButtonWidget({super.key, this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 372,
      height: 58,
      child: MaterialButton(
        color: ColorsApp.colorSecondary,
        onPressed: () => onPressed(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
    ;
  }
}
