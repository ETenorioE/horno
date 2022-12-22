import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class OrderDetailPage extends StatelessWidget with RenderPage {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Detalle de la orden',
            leading: backLeadingRender(context, MyRoutes.rLOCAL)),
        body: Stack(children: [
          backgroundImageRender(context),
          Padding(
            padding: const EdgeInsets.only(top: 63),
            child: CardWidget(
              paddingTop: 20,
              child: ListView(
                children: [
                  const Center(
                      child: TitleWidget('Ingrese el peso', fontSize: 16))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
