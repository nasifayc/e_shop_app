import 'package:dio/dio.dart';
import 'package:e_shop_app/providers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState.initial());

  void login(String email, String password) async {
    state = AuthState.loading();
    try {
      Dio dio = Dio();
      final response = await dio.post("http://localhost:5000/graphql");
    } on DioException catch (e) {
      state = AuthState.error(e.message!);
    } catch (e) {
      state = AuthState.error("An error occurred: $e");
    }
  }
}
