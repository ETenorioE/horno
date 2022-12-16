import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AvatarSmartWidgetApp extends StatelessWidget {
  final String? image;
  final String? text;
  final double radius;
  final String? assetsLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const AvatarSmartWidgetApp(
      {super.key,
      this.image,
      this.text = '',
      required this.radius,
      this.assetsLoading,
      this.backgroundColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    Color bgColor = backgroundColor ??
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    return image == null
        ? _AvatarDefaultWidget(
            initialCharacters: text!,
            radius: radius,
            backgroundColor: bgColor,
            color: textColor!,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
              placeholder: (_, __) => assetsLoading == null
                  ? const CircularProgressIndicator()
                  : Image.asset(assetsLoading!),
              imageUrl: image!,
            ),
          );
  }
}

class _AvatarDefaultWidget extends StatelessWidget {
  const _AvatarDefaultWidget({
    Key? key,
    required this.initialCharacters,
    required this.radius,
    required this.backgroundColor,
    required this.color,
  }) : super(key: key);

  final String initialCharacters;
  final double radius;
  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: Text(
          initialCharacters,
          style: TextStyle(fontSize: 40, color: color),
        ));
  }
}
