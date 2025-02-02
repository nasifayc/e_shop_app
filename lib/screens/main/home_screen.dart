import 'package:e_shop_app/providers/auth_notifier.dart';
import 'package:e_shop_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authNotifierProvider);

    if (authStatus == AuthStatus.unauthenticated) {
      return LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
