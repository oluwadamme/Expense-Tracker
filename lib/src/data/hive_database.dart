import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  final _myBox = Hive.box("Expense_DB");

  // Save data
  void saveData(List<ExpenseModel> data) async {
    await _myBox.put("ALL_EXPENSES", data);
  }

  // Read Data
  List<ExpenseModel> readData() {
    final data = _myBox.get("ALL_EXPENSES", defaultValue: <ExpenseModel>[]);
    List<ExpenseModel> value =
        (data as List).map((e) => ExpenseModel(name: e.name, amount: e.amount, dateTime: e.dateTime)).toList();
    return value;
  }
}
