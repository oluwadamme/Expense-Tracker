import 'package:expense_tracker/src/model/supabase_auth_state.dart';
import 'package:expense_tracker/src/screens/login_page.dart';
import 'package:expense_tracker/src/service/supabase_service.dart';
import 'package:expense_tracker/src/widgets/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = "/signup";
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> signup() async {
    final bloc = BlocProvider.of<SupabaseAuthService>(context);
    await bloc.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: fullNameController.text.trim(),
      userName: usernameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SupabaseAuthService, SupabaseAuthState>(
        listener: (context, state) {
          if (state.data != null) {
            context.go(LoginPage.routeName);
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
          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name field is required";
                      }
                      if (value.split(" ").length < 2) {
                        return "enter full name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name field is required";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        signup();
                      }
                    },
                    child: state.loading ? const LoadingUI() : const Text('Sign Up'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      context.go(LoginPage.routeName);
                    },
                    child: const Text('Login'),
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
