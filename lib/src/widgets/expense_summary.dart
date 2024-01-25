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
    double totalAmountWeekly() {
      final list = [
        context.read<ExpenseData>().calculateDailyExpense()[sunday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[monday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[tuesday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[wednesday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[thursday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[friday] ?? 0,
        context.read<ExpenseData>().calculateDailyExpense()[saturday] ?? 0,
      ];
      final total = list.fold(0.0, (previousValue, element) => previousValue + element);
      return total;
    }

    return SafeArea(
      child: BlocBuilder<ExpenseData, List<ExpenseModel>>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Text(
                      "Week Total: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      "\$${totalAmountWeekly().toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Expanded(
                child: MyBarGraph(
                  barData: BarData(
                    sunAmount: context.read<ExpenseData>().calculateDailyExpense()[sunday] ?? 0,
                    monAmount: context.read<ExpenseData>().calculateDailyExpense()[monday] ?? 0,
                    tueAmount: context.read<ExpenseData>().calculateDailyExpense()[tuesday] ?? 0,
                    wedAmount: context.read<ExpenseData>().calculateDailyExpense()[wednesday] ?? 0,
                    thurAmount: context.read<ExpenseData>().calculateDailyExpense()[thursday] ?? 0,
                    friAmount: context.read<ExpenseData>().calculateDailyExpense()[friday] ?? 0,
                    satAmount: context.read<ExpenseData>().calculateDailyExpense()[saturday] ?? 0,
                  ),
                  maxY: totalAmountWeekly() * 1.05,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
