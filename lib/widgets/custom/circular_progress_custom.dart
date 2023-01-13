import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: ColorsApp.colorSecondary),
    );
  }
}
