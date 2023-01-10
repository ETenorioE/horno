import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/chart/bar_chart.dart';
import 'package:horno/widgets/chart/line_chart.dart';
import 'package:horno/widgets/chart/pie_chart.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class HomePartner extends StatelessWidget with RenderPage {
  const HomePartner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PartnerService>(context);
    final local = service.local;

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'Bienvenido'),
        drawer: const DrawerPartner(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              service.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                'Ganancias totales',
                                fontSize: 18,
                                color: ColorsApp.colorTitle,
                              ),
                              const SpaceHeight(5),
                              const TitleWidget('S/ 1234.00', fontSize: 26),
                              const SpaceHeight(5),
                              const TextWidget('Actualizado hoy a las 5PM',
                                  fontSize: 18)
                            ],
                          ),
                          PieChartSample2(),
                        ],
                      ),
                    ),
              const SpaceHeight(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  TitleWidget(
                    '276',
                    fontSize: 28,
                  ),
                  SpaceWidth(6),
                  TextWidget(
                    'nuevos pedidos',
                    fontSize: 20,
                  )
                ],
              ),
              const SpaceHeight(10),
              const BarChartSample2(),
              const SpaceHeight(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _CardItemWidget(
                      bgColorIcon: ColorsApp.colorError.withOpacity(.7),
                      description: 'Total de clientes',
                      icon: Icons.group,
                      numberText: '59.8K',
                    ),
                    _CardItemWidget(
                      bgColorIcon: ColorsApp.colorSecondary.withOpacity(.7),
                      description: 'Total de pedidos',
                      icon: Icons.list_alt,
                      numberText: '500',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CardItemWidget extends StatelessWidget {
  final String numberText;
  final String description;
  final IconData icon;
  final Color bgColorIcon;

  const _CardItemWidget({
    Key? key,
    required this.numberText,
    required this.description,
    required this.icon,
    required this.bgColorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorsApp.colorText)),
      margin: const EdgeInsets.only(right: 25),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, right: 30, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: bgColorIcon),
              child: Icon(
                icon,
                color: ColorsApp.colorLight,
              ),
            ),
            const SpaceHeight(10),
            TitleWidget(numberText),
            const SpaceHeight(5),
            TextWidget(description)
          ],
        ),
      ),
    );
  }
}
