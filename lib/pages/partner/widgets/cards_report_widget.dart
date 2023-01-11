import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class CardsReportWidget extends StatelessWidget {
  const CardsReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final report = context
        .select<ReportProvider, LocalReportModel?>((value) => value.local);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _CardItemWidget(
            bgColorIcon: ColorsApp.colorError.withOpacity(.7),
            description: 'Total de clientes',
            icon: Icons.group,
            numberText: "${report!.clients}",
          ),
          _CardItemWidget(
            bgColorIcon: ColorsApp.colorSecondary.withOpacity(.7),
            description: 'Total de pedidos',
            icon: Icons.list_alt,
            numberText: "${report.orders}",
          ),
        ],
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
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorsApp.colorLight)),
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
            TitleWidget(
              numberText,
              color: bgColorIcon,
            ),
            const SpaceHeight(5),
            TextWidget(description)
          ],
        ),
      ),
    );
  }
}
