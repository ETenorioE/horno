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
                  padding: EdgeInsets.only(
                      top: orientation == Orientation.portrait ? 63 : 63 / 2),
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
                        _payment(context, provider)
                      ])))
            ])));
  }

  ButtonWidget _payment(BuildContext context, OrderService provider) {
    return ButtonWidget(
        onPressed: () {
          Navigator.pushReplacementNamed(context, MyRoutes.rPAYMENT);
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(width: 20),
          TitleWidget('Pagar S/. ${provider.total.toStringAsFixed(2)}',
              color: ColorsApp.colorLight),
          const SizedBox(width: 20),
        ]));
  }

  Center _title() {
    return const Center(child: TitleWidget('Ingrese el peso', fontSize: 20));
  }
}
