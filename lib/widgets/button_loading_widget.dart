import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class ButtonLoadingWidget extends StatelessWidget {
  final String text;
  final Widget? prefix;
  final Widget? suffix;
  final bool isLoading;
  final Function()? onPressed;
  const ButtonLoadingWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefix,
    this.suffix,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 372,
        height: 58,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          disabledColor: ColorsApp.colorPrimary,
          elevation: 1,
          color: ColorsApp.colorSecondary,
          onPressed: () => onPressed!(),
          child: isLoading
              ? CircularProgressIndicator(
                  color: ColorsApp.colorLight,
                )
              : Text(
                  text,
                  style: TextStyle(
                      color: ColorsApp.colorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
        ));
  }
}
