import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? isFontWeight;
  final Color? color;

  const TextWidget(this.text,
      {super.key,
      this.fontSize = 16,
      this.isFontWeight = true,
      this.color = const Color(0xffc2b6c2)});

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
