import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class IconButtonBgWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color? backgroundColor;
  final Function()? onPressed;

  const IconButtonBgWidget({
    Key? key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = backgroundColor ?? ColorsApp.colorLight;

    return CircleAvatar(
        radius: 16,
        backgroundColor: bgColor,
        child: IconButton(
            onPressed: () => onPressed == null ? null : onPressed!(),
            icon: Icon(icon, size: 17, color: color)));
  }
}
