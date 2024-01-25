import 'package:expense_tracker/src/bar_graph/bar_data.dart';
import 'package:expense_tracker/src/data/expense_data.dart';
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
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitle)),
        ),
        barTouchData: BarTouchData(
          touchTooltipData:
              BarTouchTooltipData(tooltipBgColor: Colors.deepPurple.shade100, direction: TooltipDirection.bottom),
        ),
        barGroups: barData.barStickList
            .map(
              (e) => BarChartGroupData(
                x: e.x,
                barRods: [
                  BarChartRodData(
                    toY: e.y,
                    color: Colors.deepPurple,
                    width: 20,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.deepPurple.shade300,
                      toY: maxY,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getBottomTitle(double value, TitleMeta meta) {
    return Text(ExpenseData().getWeekday(DateTime(DateTime.now().year, DateTime.now().month, value.toInt())));
  }
}
