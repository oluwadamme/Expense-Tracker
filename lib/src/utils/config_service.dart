import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfigService {
  ConfigService._();

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ExpenseModelAdapter());
    await Hive.openBox("Expense_DB");
  }

  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://uoidzlmpuuxnolfiwozk.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVvaWR6bG1wdXV4bm9sZml3b3prIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcxNTM5OTUsImV4cCI6MjAyMjcyOTk5NX0.GE0Q2gpUbNGjPb8YCN66CtYuhYxUR535AHC4flkbjp0',
    );
  }
}
