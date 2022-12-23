import 'package:flutter/material.dart';
import 'package:horno/models/detail_model.dart';
import 'package:horno/widgets/index.dart';

class ItemDetailWidget extends StatelessWidget {
  final DetailModel? detail;
  const ItemDetailWidget({
    Key? key,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          _image(),
          const SpaceWidth(27),
          TextWidget(detail!.text, fontSize: 16)
        ]),
        _price(),
      ],
    );
  }

  TextWidget _price() {
    return TextWidget(detail!.totalText,
        fontSize: 16, color: ColorsApp.colorTitle);
  }

  SizedBox _image() {
    return SizedBox(
      width: 52,
      height: 49,
      child: ImageNetworkRoundedWidget(
        radius: 10,
        url: detail!.serviceImage,
      ),
    );
  }
}
