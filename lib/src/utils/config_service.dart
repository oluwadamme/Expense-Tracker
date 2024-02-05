import 'package:expense_tracker/src/model/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigService {
  ConfigService._();

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ExpenseModelAdapter());
    await Hive.openBox("Expense_DB");
  }

  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? "",
      debug: kDebugMode,
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
    );
  }
}
