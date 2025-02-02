import 'dart:developer';

import 'package:e_shop_app/services/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository})
      : super(AuthStatus.unauthenticated);

  Future<void> register(String name, String email, String password) async {
    state = AuthStatus.loading;

    try {
      final token = await authRepository.register(name, email, password);

      if (token != null) {
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    } catch (e) {
      log(e.toString());
      state = AuthStatus.unauthenticated;
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    state = AuthStatus.loading;
    try {
      final token = await authRepository.signIn(email, password);
      if (token != null) {
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    } catch (e) {
      state = AuthStatus.unauthenticated;
      rethrow;
    }
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    state = AuthStatus.unauthenticated;
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository: authRepo);
});
