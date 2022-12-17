import 'package:flutter/material.dart';

class ImageNetworkRoundedWidget extends StatelessWidget {
  final double radius;
  final String url;

  const ImageNetworkRoundedWidget({
    Key? key,
    required this.radius,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
