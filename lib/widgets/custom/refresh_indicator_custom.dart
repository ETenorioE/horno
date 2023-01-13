import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class RefreshIndicatorCustom extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Key? keyIndicator;

  const RefreshIndicatorCustom(
      {super.key,
      required this.onRefresh,
      required this.child,
      this.keyIndicator});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: keyIndicator,
        color: ColorsApp.colorLight,
        backgroundColor: ColorsApp.colorSecondary,
        strokeWidth: 4.0,
        child: child,
        onRefresh: () => onRefresh());
  }
}
