// Register Mutation
import 'dart:developer';

import 'package:e_shop_app/services/graphql_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String registerMutation = r'''
  mutation Register($name: String!, $email: String!, $password: String!) {
    register(user: {name: $name, email: $email, password: $password}) {
      token
      user {
        id
        name
        email
      }
    }
  }
''';

// Sign-in Mutation
const String signInMutation = r'''
  mutation SignIn($email: String!, $password: String!) {
    signin(user: {email: $email, password: $password}) {
      token
      user {
        id
        name
        email
      }
    }
  }
''';

class AuthRepository {
  final GraphQLClient client;

  AuthRepository(this.client);

  Future<String?> register(String name, String email, String password) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(registerMutation),
        variables: {"name": name, "email": email, "password": password},
      ),
    );

    if (result.hasException) {
      log(result.exception.toString());
      throw Exception(result.exception.toString());
    }

    final token = result.data?['register']['token'];

    await _saveToken(token);
    return token;
  }

  Future<String?> signIn(String email, String password) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(signInMutation),
        variables: {"email": email, "password": password},
      ),
    );

    if (result.hasException) {
      log(result.exception.toString());
      throw Exception(result.exception.toString());
    }

    final token = result.data?['signin']['token'];
    await _saveToken(token);
    return token;
  }

  Future<void> _saveToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token ?? '');
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return AuthRepository(client);
});
