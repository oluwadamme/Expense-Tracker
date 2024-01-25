import 'package:expense_tracker/src/bar_graph/bar_data.dart';
import 'package:expense_tracker/src/bar_graph/my_bar_graph.dart';
import 'package:expense_tracker/src/data/expense_data.dart';
import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key, required this.startOfWeek});
  final DateTime startOfWeek;
  @override
  Widget build(BuildContext context) {
    final sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    final monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    final tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    final wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    final thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    final friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    final saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return SafeArea(
      child: BlocBuilder<ExpenseData, List<ExpenseModel>>(
        builder: (context, state) {
          return MyBarGraph(
            barData: BarData(
              sunAmount: context.read<ExpenseData>().calculateDailyExpense()[sunday] ?? 0,
              monAmount: context.read<ExpenseData>().calculateDailyExpense()[monday] ?? 0,
              tueAmount: context.read<ExpenseData>().calculateDailyExpense()[tuesday] ?? 0,
              wedAmount: context.read<ExpenseData>().calculateDailyExpense()[wednesday] ?? 0,
              thurAmount: context.read<ExpenseData>().calculateDailyExpense()[thursday] ?? 0,
              friAmount: context.read<ExpenseData>().calculateDailyExpense()[friday] ?? 0,
              satAmount: context.read<ExpenseData>().calculateDailyExpense()[saturday] ?? 0,
            ),
            maxY: state
                .map((e) => double.parse(e.amount))
                .fold(0, (previousValue, element) => (previousValue ?? 0) + element),
          );
        },
      ),
    );
  }
}
