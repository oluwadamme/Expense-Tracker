import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseData extends BlocBase {
  // list of all expenses
  List<ExpenseModel> overallExpenseList = [];

  ExpenseData(super.state);

  // get all expenses
  List<ExpenseModel> getAllExpense() {
    return overallExpenseList;
  }

  //add expense to list
  void addExpense(ExpenseModel expense) {
    overallExpenseList.add(expense);
  }

  // delete expense to list
  void deleteExpense(ExpenseModel expense) {
    overallExpenseList.remove(expense);
  }

  // get weekday
  String getWeekday(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "";
    }
  }

  // get the start of the week
  DateTime? startOfWeek() {
    final today = DateTime.now();
    for (var i = 0; i < 7; i++) {
      if (getWeekday(today.subtract(Duration(days: i))) == "Sun") {
        return today.subtract(Duration(days: i));
      }
    }
    return null;
  }

  Map<String, double> calculateDailyExpense() {
    // date (yyyymmmd):amountTotalPerDay
    Map<String, double> dailyExpense = {};

    for (var expense in overallExpenseList) {
      final date = convertDateTimeToString(expense.dateTime);
      final amount = double.parse(expense.amount);
      if (dailyExpense.containsKey(date)) {
        double currentAmount = dailyExpense[date]!;
        currentAmount += amount;
        dailyExpense[date] = currentAmount;
      } else {
        dailyExpense[date] = amount;
      }
    }
    return dailyExpense;
  }
}

String convertDateTimeToString(DateTime dateTime) {
  // year in format yyyy
  final year = dateTime.year.toString();

  // month in format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }
  // day in format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  return year + month + day;
}
