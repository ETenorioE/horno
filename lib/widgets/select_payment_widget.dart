import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class SelectPaymentWidget extends StatelessWidget {
  final String image;
  final bool isSelected;
  final Function(String)? onTap;
  const SelectPaymentWidget(
      {super.key, required this.image, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap != null ? onTap!(image) : null,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            width: 60,
            height: 57,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorsApp.colorPrimary),
            child: ImageNetworkRoundedWidget(
                radius: 10, url: 'payment/$image.png', isNetwork: false),
          ),
          Positioned(
              top: -5,
              right: -5,
              child: Visibility(
                  visible: isSelected,
                  child: Image.asset('assets/payment/select.png',
                      fit: BoxFit.cover, height: 22, width: 22)))
        ]));
  }
}
