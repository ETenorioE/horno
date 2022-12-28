import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class StateProcess extends StatelessWidget with RenderPage {
  const StateProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Pedido'),
      ),
    );
  }
}
