import 'package:expense_tracker/src/bar_graph/bar_stick.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  List<BarStick> barStickList = [];

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  //intialize bar data

  void intializeBarData() {
    barStickList = [
      // sun
      BarStick(x: 0, y: sunAmount),
      // mon
      BarStick(x: 1, y: monAmount),
      BarStick(x: 2, y: tueAmount),
      BarStick(x: 3, y: wedAmount),
      BarStick(x: 4, y: thurAmount), // sun
      BarStick(x: 5, y: friAmount), // sun
      BarStick(x: 6, y: satAmount),
    ];
  }
}
