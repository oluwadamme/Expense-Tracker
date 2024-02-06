import 'package:expense_tracker/src/model/supabase_auth_state.dart';
import 'package:expense_tracker/src/screens/home_page.dart';
import 'package:expense_tracker/src/screens/signup_page.dart';
import 'package:expense_tracker/src/service/supabase_service.dart';
import 'package:expense_tracker/src/widgets/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = "/login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> signin() async {
    final bloc = BlocProvider.of<SupabaseAuthService>(context);
    await bloc.signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: BlocConsumer<SupabaseAuthService, SupabaseAuthState>(
        listener: (context, state) {
          if (state.data != null) {
            context.go(HomePage.routeName);
            return;
          }
          if (state.error != null) {
            Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email field is required";
                      }
                      if (!value.contains("@")) {
                        return "Email is invalid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "password field is required";
                      }
                      if (value.length < 8) {
                        return "field must be less than 8 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your login logic here
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        signin();
                      }
                    },
                    child: state.loading ? const LoadingUI() : const Text('Login'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Implement your forgot password logic here
                    },
                    child: const Text('Forgot Password?'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go(SignUpPage.routeName);
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
