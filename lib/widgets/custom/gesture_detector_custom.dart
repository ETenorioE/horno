import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GestureDetectorCustom extends StatelessWidget {
  final Widget child;
  final BuildContext context;
  const GestureDetectorCustom(
      {super.key, required this.child, required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}
