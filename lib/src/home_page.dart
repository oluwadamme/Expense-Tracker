import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:expense_tracker/src/data/expense_data.dart';
import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:expense_tracker/src/widgets/expense_summary.dart';
import 'package:expense_tracker/src/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseData>(context).getAllExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addExpenseDialog(null),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExpenseData, List<ExpenseModel>>(builder: (context, state) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: ExpenseSummary(startOfWeek: context.read<ExpenseData>().startOfWeek() ?? DateTime.now()),
            ),
            Expanded(
              flex: 3,
              child: state.isEmpty
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration:
                            BoxDecoration(color: Colors.deepPurple.shade100, borderRadius: BorderRadius.circular(8)),
                        height: 100,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: const Text(
                          'No expense made yet',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, index) {
                        List<Map<DateTime, List<ExpenseModel>>> groupedItems = state
                            .groupListsBy(
                                (ExpenseModel item) => (DateTime.parse(item.dateTime.toString().substring(0, 10))))
                            .entries
                            .map((entry) => {entry.key: entry.value})
                            .toList();

                        return StickyHeader(
                          header: Text(DateFormat.yMMMMd().format(groupedItems[index].keys.first)),
                          content: Column(
                            children: [
                              ...List.generate(
                                groupedItems[index].values.first.length,
                                (index2) => ExpenseTile(
                                  expense: groupedItems[index].values.first[index2],
                                  onDelete: (context) => deleteExpense(groupedItems[index].values.first[index2]),
                                  onUpdate: (context) => addExpenseDialog(groupedItems[index].values.first[index2]),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: getLenghtofGroupedExpenseList(state),
                    ),
            ),
          ],
        );
      }),
    );
  }

  int getLenghtofGroupedExpenseList(List<ExpenseModel> list) {
    List<Map<DateTime, List<ExpenseModel>>> groupedItems = list
        .groupListsBy((ExpenseModel item) => (DateTime.parse(item.dateTime.toString().substring(0, 10))))
        .entries
        .map((entry) => {entry.key: entry.value})
        .toList();

    return groupedItems.length;
  }

  void addExpenseDialog(ExpenseModel? expense) {
    if (expense != null) {
      nameController.text = expense.name;
      amountController.text = expense.amount;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add new expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Expense name", hintStyle: TextStyle(fontSize: 12)),
            ),
            // expense amount
            TextFormField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: "Expense amount", hintStyle: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () => saveExpense(expense),
            color: Colors.deepPurple.shade400,
            child: const Text(
              "Save",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  void saveExpense(ExpenseModel? expenseModel) {
    if (nameController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty ||
        double.parse(amountController.text.trim()) <= 0) return;
    final expense = ExpenseModel(
      name: nameController.text.trim(),
      amount: amountController.text.trim(),
      dateTime: expenseModel == null ? DateTime.now() : expenseModel.dateTime,
    );
    if (expenseModel == null) {
      context.read<ExpenseData>().addExpense(expense);
    } else {
      context.read<ExpenseData>().updateExpense(expense);
    }

    Navigator.pop(context);
    clear();
    setState(() {});
  }

  void deleteExpense(ExpenseModel expense) {
    context.read<ExpenseData>().deleteExpense(expense);
    setState(() {});
  }

  void clear() {
    nameController.clear();
    amountController.clear();
  }
}
