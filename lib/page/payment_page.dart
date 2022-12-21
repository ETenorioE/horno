import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class PaymentPage extends StatelessWidget with RenderPage {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Pagar',
            leading: InkWell(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyRoutes.rLOCAL);
              },
            )),
        body: Stack(children: [
          backgroundImageRender(context),
          Padding(
            padding: const EdgeInsets.only(top: 63),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 38, bottom: 20),
              decoration: BoxDecoration(
                  color: ColorsApp.colorLight,
                  borderRadius: borderRadiusTopRender(radius: 20)),
              child: ListView(
                children: [
                  _details(context),
                  const SpaceHeight(20),
                  _payment(context),
                  const SpaceHeight(20),
                  _button()
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox _button() {
    return SizedBox(
      width: 372,
      height: 58,
      child: MaterialButton(
        color: ColorsApp.colorSecondary,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: TitleWidget(
          'Confirmar',
          color: ColorsApp.colorLight,
        ),
      ),
    );
  }

  Container _payment(BuildContext context) {
    return Container(
      decoration: _borderRadiusAndColor(),
      padding: _paddingCard(),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const TitleWidget('Metodo de pago', fontSize: 16),
          const SpaceHeight(18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SelectPaymentWidget(image: 'visa', isSelected: true),
              SelectPaymentWidget(image: 'yape', isSelected: false),
              SelectPaymentWidget(image: 'tunki', isSelected: false),
            ],
          )
        ],
      ),
    );
  }

  Container _details(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: _paddingCard(),
      decoration: _borderRadiusAndColor(),
      child: Column(
        children: [
          const TitleWidget('Detalle de la ordern #453', fontSize: 16),
          const SpaceHeight(18),
          SizedBox(
            height: 140,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextWidget("1 pavo de 10Kg"),
                    TextWidget('S/. 30.00')
                  ],
                )
              ],
            ),
          ),
          const SpaceHeight(30),
          Divider(height: 4, color: ColorsApp.colorPrimary),
          const SpaceHeight(11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TitleWidget('Total a pagar', fontSize: 16),
              TitleWidget('S/. 65.00', fontSize: 16)
            ],
          )
        ],
      ),
    );
  }

  EdgeInsets _paddingCard() {
    return const EdgeInsets.symmetric(vertical: 11, horizontal: 17);
  }

  BoxDecoration _borderRadiusAndColor() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsApp.colorPrimary));
  }
}
