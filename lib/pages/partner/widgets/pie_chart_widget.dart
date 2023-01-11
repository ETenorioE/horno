import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class PieChartWidget extends StatefulWidget {
  final double revenue;
  final double revenuePrevious;
  const PieChartWidget({
    super.key,
    required this.revenue,
    required this.revenuePrevious,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(children: [
        PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: TextWidget(
              showPercentage,
              fontSize: 18,
              color: ColorsApp.colorSecondary,
            )),
      ]),
    );
  }

  String get showPercentage {
    double rest = widget.revenue - widget.revenuePrevious;

    if (rest == 0) {
      return "+0%";
    }

    double percentage = (widget.revenuePrevious / widget.revenue) * 100;

    return "+$percentage%";
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 10.0 : 5.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: ColorsApp.colorTitle,
            value: widget.revenue,
            radius: radius,
            title: '',
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: ColorsApp.colorLight,
            value: widget.revenue - widget.revenuePrevious,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: ColorsApp.colorSecondary,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
