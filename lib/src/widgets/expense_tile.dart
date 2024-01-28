import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense, required this.onDelete, required this.onUpdate});
  final ExpenseModel expense;
  final Function(BuildContext)? onDelete;
  final Function(BuildContext)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: onUpdate,
          icon: Icons.edit,
          backgroundColor: Colors.purple,
        ),
        SlidableAction(
          onPressed: onDelete,
          icon: Icons.delete,
          backgroundColor: Colors.red,
        ),
      ]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(expense.name),
        trailing: Text("\$${expense.amount}"),
        subtitle: Text(DateFormat('HH:mm:ss').format(expense.dateTime)),
      ),
    );
  }
}
