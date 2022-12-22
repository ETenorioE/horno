import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class CardWidget extends StatelessWidget with RenderPage {
  final Widget? child;
  final double? paddingTop;
  const CardWidget({super.key, this.child, this.paddingTop = 38});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        padding:
            EdgeInsets.only(right: 20, left: 20, top: paddingTop!, bottom: 20),
        decoration: BoxDecoration(
            color: ColorsApp.colorLight,
            borderRadius: borderRadiusTopRender(radius: 20)),
        child: child);
  }
}
