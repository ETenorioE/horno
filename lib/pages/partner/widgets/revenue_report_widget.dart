import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/pages/partner/widgets/pie_chart_widget.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class RevenueReportWidget extends StatelessWidget {
  const RevenueReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportProvider>(context);
    final localReport = provider.local;
    final prevLocalReport = provider.prevLocal;

    return SizedBox(
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
              TitleWidget(
                localReport!.revenueText,
                fontSize: 26,
                color: ColorsApp.colorSecondary,
              ),
              const SpaceHeight(5),
              TextWidget(
                'Actualizado hoy a las ${provider.hour}',
                fontSize: 18,
                color: ColorsApp.colorTitle.withOpacity(.6),
              )
            ],
          ),
          PieChartWidget(
            revenue: localReport.revenue,
            revenuePrevious: prevLocalReport == null
                ? localReport.revenue
                : prevLocalReport.revenue,
          ),
        ],
      ),
    );
  }
}
