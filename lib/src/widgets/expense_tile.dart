import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.expense,
  });
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.name),
      trailing: Text("\$${expense.amount}"),
      subtitle: Text(expense.dateTime.toString()),
    );
  }
}
