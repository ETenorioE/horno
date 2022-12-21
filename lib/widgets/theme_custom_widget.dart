import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class ThemeCustomWidget extends StatelessWidget {
  final Widget child;

  const ThemeCustomWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryIconTheme: IconThemeData(
            color: ColorsApp.colorLight,
          ),
        ),
        child: child);
  }
}
