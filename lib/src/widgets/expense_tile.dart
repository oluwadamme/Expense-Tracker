import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense, required this.onPressed});
  final ExpenseModel expense;
  final Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: onPressed,
          icon: Icons.delete,
          backgroundColor: Colors.red,
        )
      ]),
      child: ListTile(
        title: Text(expense.name),
        trailing: Text("\$${expense.amount}"),
        subtitle: Text("${expense.dateTime.day} / ${expense.dateTime.month} / ${expense.dateTime.year}"),
      ),
    );
  }
}
