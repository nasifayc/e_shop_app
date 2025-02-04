import 'package:e_shop_app/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.initial() = _initial;
  factory AuthState.loading() = _loading;
  factory AuthState.authenticated(String token, UserModel user) =
      _authenticated;
  factory AuthState.error(String message) = _error;
}
