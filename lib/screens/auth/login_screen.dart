import 'dart:developer';

import 'package:e_shop_app/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _signin() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    try {
      await authNotifier.signIn(
          _emailController.text.trim(), _passwordController.text.trim());
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = ref.watch(authNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (authStatus == AuthStatus.loading) {
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    _signin();
                  }
                },
                child: authStatus == AuthStatus.loading
                    ? CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : Text('Login'),
              ),
              SizedBox(height: 10),
              Text('Forgot Password?'),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    context.go("/signup");
                  },
                  child: Text('Don\'t have an account? Sign up')),
            ],
          ),
        ),
      ),
    );
  }
}
