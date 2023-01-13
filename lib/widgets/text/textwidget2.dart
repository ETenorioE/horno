import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/widgets/index.dart';

class TextWidget2 extends StatelessWidget {
  final String text;

  const TextWidget2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(
        fontSize: 18,
        color: ColorsApp.colorText,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
