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
        gradient: LinearGradient(
            begin: const Alignment(-1.0, -1),
            end: const Alignment(-1.0, 1),
            colors: [ColorsApp.colorPrimary, ColorsApp.colorLight],
            stops: const [0.02, 0.02]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsApp.colorPrimary, width: .8));
  }

  InputDecoration decorationTextFormField({
    final String? hinttext,
    final Widget? suffixIcon,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: ColorsApp.colorPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.5, color: ColorsApp.colorPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: ColorsApp.colorError),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: ColorsApp.colorError),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: hinttext,
      suffixIcon: suffixIcon,
      hintStyle: TextStyle(color: ColorsApp.colorText),
    );
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
