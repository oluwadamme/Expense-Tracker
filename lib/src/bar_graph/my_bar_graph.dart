import 'package:expense_tracker/src/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, this.maxY, required this.barData});
  final double? maxY;
  final BarData barData;
  @override
  Widget build(BuildContext context) {
    barData.intializeBarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        barGroups:
            barData.barStickList.map((e) => BarChartGroupData(x: e.x, barRods: [BarChartRodData(toY: e.y)])).toList(),
      ),
    );
  }
}
