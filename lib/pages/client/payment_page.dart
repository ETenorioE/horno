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
              leading: backLeadingRender(context, MyRoutes.rOrderDetail)),
          body: Stack(children: [
            backgroundImageRender(context),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CardWidget(
                    child: ListView(children: [
                  _details(context, provider),
                  const SpaceHeight(20),
                  _paymentMethod(context, provider),
                  const SpaceHeight(20),
                ]))),
            Align(
                alignment: Alignment.bottomCenter,
                child: _payment(provider, service, context))
          ])),
    );
  }

  Padding _payment(
      OrderService provider, PaymentService service, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonWidget(
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
                EasyLoading.instance.backgroundColor = ColorsApp.colorSuccess;

                await provider.clearData();

                EasyLoading.showSuccess(response.msg);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, MyRoutes.rLOCAL);
              } else {
                EasyLoading.instance.backgroundColor = ColorsApp.colorError;

                EasyLoading.showError(response.msg);
              }
            },
            text: 'Confirmar'));
  }

  Container _paymentMethod(BuildContext context, OrderService provider) {
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
              height: orientation == Orientation.portrait ? 190 : 190 / 2,
              child: ListView.separated(
                itemCount: provider.details.length,
                separatorBuilder: (context, index) => const SpaceHeight(12),
                itemBuilder: (context, index) {
                  final item = provider.details[index];
                  return _ItemDetailWidget(detail: item);
                },
              )),
          const SpaceHeight(11),
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
