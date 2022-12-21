import 'package:flutter/material.dart';

class ImageNetworkRoundedWidget extends StatelessWidget {
  final double radius;
  final String url;
  final bool? isNetwork;

  const ImageNetworkRoundedWidget({
    Key? key,
    required this.radius,
    required this.url,
    this.isNetwork = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: isNetwork!
            ? Image.network(
                url,
                fit: BoxFit.cover,
              )
            : Image.asset('assets/$url'));
  }
}
