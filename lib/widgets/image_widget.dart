import 'package:cached_network_image/cached_network_image.dart';
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
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: ((context, url) =>
                    Image.asset('assets/images/loading_2.gif')),
                imageUrl: url,
              )
            : Image.asset('assets/$url'));
  }
}
