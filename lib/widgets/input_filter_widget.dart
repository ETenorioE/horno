import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/widgets/index.dart';

class InputFilterWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;
  const InputFilterWidget({super.key, this.onChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            height: 42,
            child: TextFormField(
              style: inputStyle(ColorsApp.colorSecondary),
              decoration: inputDecoration(hintText: hintText),
              onChanged: (value) =>
                  onChanged != null ? onChanged!(value) : null,
            ),
          ),
          IconButton(
              onPressed: (() {}),
              icon: Icon(
                Icons.filter_list,
                color: ColorsApp.colorSecondary,
              ))
        ],
      ),
    );
  }

  InputDecoration inputDecoration({required String hintText}) {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 18),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: ColorsApp.colorSecondary,
          ),
        ),
        enabledBorder: outline(ColorsApp.colorSecondary),
        focusedBorder: outline(ColorsApp.colorSecondary),
        border: outline(ColorsApp.colorSecondary),
        hintText: hintText,
        hintStyle: inputStyle(ColorsApp.colorSecondary));
  }

  TextStyle inputStyle(Color colorSecondary) {
    return GoogleFonts.openSans(
        color: colorSecondary, fontSize: 16, fontWeight: FontWeight.bold);
  }

  OutlineInputBorder outline(Color colorSecondary) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 1, color: colorSecondary));
  }
}
