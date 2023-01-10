import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? isFontWeight;
  final Color? color;

  const TitleWidget(this.text,
      {super.key,
      this.fontSize = 22,
      this.isFontWeight = true,
      this.color = const Color(0xff634561)});

  @override
  Widget build(BuildContext context) {
    final fontWeight = isFontWeight! ? FontWeight.bold : FontWeight.normal;

    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
