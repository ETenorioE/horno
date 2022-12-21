import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class IconAndTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final Color? colorText;

  const IconAndTextWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorIcon = color ?? ColorsApp.colorText;
    Color _colorText = colorText ?? ColorsApp.colorText;

    return Row(
      children: [
        Icon(
          icon,
          color: colorIcon,
          size: 17,
        ),
        const SpaceWidth(5),
        TextWidget(
          text,
          color: _colorText,
        )
      ],
    );
  }
}
