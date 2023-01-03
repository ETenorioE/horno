import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatelessWidget with RenderPage {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final provider = Provider.of<OrderService>(context);

    return ThemeCustomWidget(
        child: Scaffold(
            appBar: appBarRender(
                title: 'Detalle de la orden',
                leading: backLeadingRender(context, MyRoutes.rLOCAL)),
            body: Stack(children: [
              backgroundImageRender(context),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CardWidget(
                      paddingTop: 20,
                      child: ListView(children: [
                        _title(),
                        SpaceHeight(
                            orientation == Orientation.portrait ? 30 : 30 / 2),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? 370
                              : 370 / 2,
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final item = provider.details[index];

                                return ItemOrderWidget(detail: item);
                              },
                              separatorBuilder: (context, index) =>
                                  const SpaceHeight(20),
                              itemCount: provider.details.length),
                        ),
                        const SpaceHeight(20),
                      ]))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: _payment(context, provider))
            ])));
  }

  Padding _payment(BuildContext context, OrderService provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ButtonWidget(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MyRoutes.rPAYMENT);
          },
          text: 'Pagar S/. ${provider.total.toStringAsFixed(2)}'),
    );
  }

  Center _title() {
    return const Center(child: TitleWidget('Ingrese el peso', fontSize: 20));
  }
}
