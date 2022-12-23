import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/database/index.dart';
import 'package:horno/models/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget with RenderPage {
  const PaymentPage({super.key});

  static const payments = ['visa', 'yape', 'tunki'];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderService>(context);
    final service = Provider.of<PaymentService>(context, listen: false);

    final orientation = MediaQuery.of(context).orientation;

    return ThemeCustomWidget(
      child: Scaffold(
          appBar: appBarRender(
              title: 'Pagar',
              leading: backLeadingRender(context, MyRoutes.rORDER_DETAIL)),
          body: Stack(children: [
            backgroundImageRender(context),
            Padding(
                padding: EdgeInsets.only(
                    top: orientation == Orientation.portrait ? 63 : 63 / 2),
                child: CardWidget(
                    child: ListView(children: [
                  _details(context, provider),
                  const SpaceHeight(20),
                  _payment(context, provider),
                  const SpaceHeight(20),
                  ButtonWidget(
                      onPressed: () async {
                        final orderLocal = provider.order;
                        if (orderLocal == null) return;

                        final response = await service.save(
                          order: orderLocal,
                          details: provider.details,
                          paymentMethod: provider.paymentMethod,
                          total: provider.total,
                        );

                        if (response.state == StateProcess.success) {
                          EasyLoading.instance.backgroundColor =
                              ColorsApp.colorSuccess;
                          EasyLoading.showSuccess(response.msg);

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.rLOCAL);
                        } else {
                          EasyLoading.instance.backgroundColor =
                              ColorsApp.colorError;

                          EasyLoading.showError(response.msg);
                        }
                      },
                      child:
                          TitleWidget('Confirmar', color: ColorsApp.colorLight))
                ])))
          ])),
    );
  }

  Container _payment(BuildContext context, OrderService provider) {
    return Container(
      decoration: borderRadiusAndColorRender(),
      padding: _paddingCard(),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const TitleWidget('Metodo de pago', fontSize: 16),
          const SpaceHeight(18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: payments
                .map(
                  (e) => SelectPaymentWidget(
                    image: e,
                    isSelected: e == provider.paymentMethod,
                    onTap: (value) {
                      provider.setPaymentMethod(value);
                    },
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Container _details(BuildContext context, OrderService provider) {
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: _paddingCard(),
      decoration: borderRadiusAndColorRender(),
      child: Column(
        children: [
          const TitleWidget('Detalle de la orden', fontSize: 16),
          const SpaceHeight(18),
          SizedBox(
              height: orientation == Orientation.portrait ? 140 : 140 / 2,
              child: ListView.separated(
                itemCount: provider.details.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SpaceHeight(12),
                itemBuilder: (context, index) {
                  final item = provider.details[index];
                  return _ItemDetailWidget(detail: item);
                },
              )),
          const SpaceHeight(30),
          Divider(height: 4, color: ColorsApp.colorPrimary),
          const SpaceHeight(11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleWidget('Total a pagar', fontSize: 16),
              TitleWidget('S/. ${provider.total.toStringAsFixed(2)}',
                  fontSize: 16)
            ],
          )
        ],
      ),
    );
  }

  EdgeInsets _paddingCard() {
    return const EdgeInsets.symmetric(vertical: 11, horizontal: 17);
  }
}

class _ItemDetailWidget extends StatelessWidget {
  final DetailDbModel detail;
  const _ItemDetailWidget({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextWidget("${detail.serviceName} de ${detail.weight}kg"),
      TextWidget('S/. ${detail.total?.toStringAsFixed(2)}')
    ]);
  }
}
