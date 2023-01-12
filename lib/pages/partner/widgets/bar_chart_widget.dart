import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:horno/models/day_report_model.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/theme/theme.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class BarChatWidget extends StatefulWidget {
  const BarChatWidget({super.key});

  @override
  State<StatefulWidget> createState() => BarChatWidgetState();
}

class BarChatWidgetState extends State<BarChatWidget> {
  final Color leftBarColor = ColorsApp.colorPrimary;
  final Color rightBarColor = ColorsApp.colorSecondary;
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final items = List.generate(7, (index) => makeGroupData(index, 0, 0));

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final days = context
        .select<ReportProvider, List<DayReportModel>>((value) => value.days);

    return SizedBox(
      height: 400,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: ColorsApp.colorLight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 100,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                              rod.toY.toString(),
                              const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14));
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: matchData(days),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IndicatorWidget(
                      color: ColorsApp.colorPrimary,
                      text: '# Pedidos',
                      isSquare: true),
                  IndicatorWidget(
                      color: ColorsApp.colorSecondary,
                      text: 'S/. Total',
                      isSquare: true),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> matchData(List<DayReportModel> days) {
    DayReportModel? report;
    BarChartGroupData chart;
    List<BarChartGroupData> charts = [];

    for (var i = 0; i < 7; i++) {
      try {
        report = days.firstWhere((element) => element.day.weekday == i + 1);
      } catch (e) {
        report = null;
      }

      if (report != null) {
        double limitOrder =
            report.orders > 100 ? 100.0 : report.orders.toDouble();
        double limitRevenue = report.revenue > 100.0 ? 100.0 : report.revenue;

        chart = makeGroupData(i, limitOrder, limitRevenue);
      } else {
        chart = makeGroupData(i, 0, 0);
      }

      charts.add(chart);
    }

    return charts;
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '1';
    } else if (value == 50) {
      text = '>50';
    } else if (value == 99) {
      text = '>100';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa', 'Do'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
        BarChartRodData(toY: y2, color: rightBarColor, width: width),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
