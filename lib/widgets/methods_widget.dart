import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

mixin RenderPage {
  AppBar appBarRender({
    required String title,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return AppBar(
      title: TitleWidget(
        title,
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: ColorsApp.colorSecondary,
      leading: leading,
      actions: actions,
    );
  }

  Container backgroundImageRender(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/bg.png'),
        fit: BoxFit.cover,
      )),
    );
  }

  BorderRadius borderRadiusTopRender({double? radius = 10}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius!),
      topRight: Radius.circular(radius),
    );
  }
}
