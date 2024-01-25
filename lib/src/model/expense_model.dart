import 'package:hive_flutter/hive_flutter.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String amount;

  @HiveField(2)
  DateTime dateTime;

  ExpenseModel({required this.name, required this.amount, required this.dateTime});
}
