import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class ItemServiceWidget extends StatelessWidget {
  const ItemServiceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorsApp.colorPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 52,
            height: 49,
            child: ImageNetworkRoundedWidget(
                radius: 10,
                url:
                    'https://cdn.pixabay.com/photo/2013/12/21/18/02/thanksgiving-231781_960_720.jpg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWidget(
                'Hornear Pavo',
                fontSize: 19,
              ),
              const SpaceHeight(5),
              Row(
                children: const [
                  TextWidget("Precio por kilo"),
                  SpaceWidth(29),
                  TitleWidget(
                    'S/.30.0',
                    fontSize: 19,
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward,
            color: ColorsApp.colorPrimary,
          )
        ],
      ),
    );
  }
}
