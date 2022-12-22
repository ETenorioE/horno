import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:horno/widgets/item_order_widget.dart';

class OrderDetailPage extends StatelessWidget with RenderPage {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(
            title: 'Detalle de la orden',
            leading: backLeadingRender(context, MyRoutes.rLOCAL)),
        body: Stack(children: [
          backgroundImageRender(context),
          Padding(
            padding: EdgeInsets.only(
                top: orientation == Orientation.portrait ? 63 : 20),
            child: CardWidget(
              paddingTop: 20,
              child: ListView(
                children: [
                  const Center(
                      child: TitleWidget('Ingrese el peso', fontSize: 20)),
                  SpaceHeight(orientation == Orientation.portrait ? 30 : 15),
                  SizedBox(
                    height: orientation == Orientation.portrait ? 370 : 200,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ItemOrderWidget(
                              text: 'Pavo',
                              price: 35,
                              image:
                                  'https://cdn.pixabay.com/photo/2013/12/21/18/02/thanksgiving-231781_960_720.jpg');
                        },
                        separatorBuilder: (context, index) => SpaceHeight(20),
                        itemCount: 2),
                  ),
                  const SpaceHeight(20),
                  ButtonWidget(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MyRoutes.rPAYMENT);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        TitleWidget('Pagar S/. 65.00',
                            color: ColorsApp.colorLight),
                        const SizedBox(width: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
