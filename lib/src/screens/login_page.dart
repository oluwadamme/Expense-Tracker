import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () {
            // Implement your login logic here
            print('Email: ${emailController.text}');
            print('Password: ${passwordController.text}');
          },
          child: const Text('Login'),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () {
            // Implement your forgot password logic here
            print('Forgot Password');
          },
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }
}
