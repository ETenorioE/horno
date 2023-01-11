import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class DayOrdersReportWidget extends StatelessWidget {
  const DayOrdersReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersDay = context.select<ReportProvider, int>(
      (value) => value.ordersDay,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleWidget(
          "$ordersDay",
          fontSize: 28,
          color: ColorsApp.colorSecondary,
        ),
        const SpaceWidth(6),
        TextWidget(
          messageText(ordersDay),
          fontSize: 20,
          color: ColorsApp.colorTitle.withOpacity(.6),
        )
      ],
    );
  }

  String messageText(int ordersDay) {
    switch (ordersDay) {
      case 0:
        return 'pedidos nuevos';
      case 1:
        return 'pedido nuevo';
      default:
        return 'nuevos pedidos';
    }
  }

  String findOrdersDay(List<DayReportModel> days) {
    final day = DateTime.now();
    DayReportModel? orders;

    try {
      orders = days.firstWhere((element) => element.day.day == day.day);
    } catch (e) {
      orders = null;
    }

    return orders == null ? "0" : orders.orders.toString();
  }
}
