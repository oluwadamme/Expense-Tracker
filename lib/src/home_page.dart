import 'package:expense_tracker/src/data/expense_data.dart';
import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:expense_tracker/src/widgets/expense_summary.dart';
import 'package:expense_tracker/src/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: addExpenseDialog,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExpenseData, List<ExpenseModel>>(builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: ExpenseSummary(startOfWeek: context.read<ExpenseData>().startOfWeek() ?? DateTime.now()),
            ),
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemBuilder: (context, index) => ExpenseTile(
                  expense: state[index],
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.length,
              ),
            ),
          ],
        );
      }),
    );
  }

  void addExpenseDialog() {
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
            onPressed: saveExpense,
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

  void saveExpense() {
    final expense = ExpenseModel(
      name: nameController.text.trim(),
      amount: amountController.text.trim(),
      dateTime: DateTime.now(),
    );
    context.read<ExpenseData>().addExpense(expense);
    Navigator.pop(context);
    clear();
    setState(() {});
  }

  void clear() {
    nameController.clear();
    amountController.clear();
  }
}
