import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

mixin RenderPage {
  AppBar appBarRender(
      {required String title, Widget? leading, List<Widget>? actions}) {
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
}
