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
      elevation: 0,
    );
  }

  BorderRadius borderRadiusTopRender({double? radius = 10}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius!),
      topRight: Radius.circular(radius),
    );
  }

  InkWell backLeadingRender(BuildContext context, String route) {
    return InkWell(
      child: const Icon(Icons.arrow_back),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  Container backgroundImageRender(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: onlyDecorationBackground(),
    );
  }

  BoxDecoration borderRadiusAndColorRender() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsApp.colorPrimary));
  }
}

BoxDecoration onlyDecorationBackground() {
  return const BoxDecoration(
      image: DecorationImage(
    image: AssetImage('assets/images/bg.png'),
    fit: BoxFit.cover,
  ));
}

Image imageNetworkCustom(String url) => Image.network(url, fit: BoxFit.cover);
