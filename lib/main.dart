import 'package:expense_tracker/src/data/expense_data.dart';
import 'package:expense_tracker/src/service/supabase_service.dart';
import 'package:expense_tracker/src/utils/config_service.dart';
import 'package:expense_tracker/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  await ConfigService.initHive();
  await ConfigService.initSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExpenseData()),
        BlocProvider(create: (context) => SupabaseAuthService()),
      ],
      child: MaterialApp.router(
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
