import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:horno/theme/theme.dart';
import 'package:horno/widgets/chart/indicador_chart.dart';
import 'package:horno/widgets/index.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
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
              '+9%',
              fontSize: 20,
              color: ColorsApp.colorSecondary,
            )),
      ]),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 10.0 : 5.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: ColorsApp.colorSecondary,
            value: 81,
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
            value: 9,
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
