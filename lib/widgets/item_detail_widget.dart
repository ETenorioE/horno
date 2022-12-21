import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            SizedBox(
              width: 52,
              height: 49,
              child: ImageNetworkRoundedWidget(
                  radius: 10,
                  url:
                      'https://cdn.pixabay.com/photo/2013/12/21/18/02/thanksgiving-231781_960_720.jpg'),
            ),
            SpaceWidth(27),
            TextWidget(
              '1 Pavo de 10kg',
              fontSize: 16,
            ),
          ],
        ),
        TextWidget(
          "S/.35.0",
          fontSize: 16,
          color: ColorsApp.colorTitle,
        ),
      ],
    );
  }
}
