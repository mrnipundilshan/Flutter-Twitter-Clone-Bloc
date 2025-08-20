import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/models/LoginParams.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient client;

  SupabaseAuthRepository({required this.client});

  @override
  Future<String> login({required LoginParams loginParams}) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: loginParams.email,
        password: loginParams.password,
      );
      final session = response.session;
      if (session == null || session.accessToken.isEmpty) {
        throw Exception('Invalid Session');
      }

      return session.accessToken;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  @override
  Future<String> register({required UserEntity user}) async {
    try {
      final response = await client.auth.signUp(
        password: user.password,
        email: user.email,
        data: {'username': user.username},
      );
      final session = response.session;

      if (session == null || session.accessToken.isEmpty) {
        throw Exception('Invalid session');
      }

      return session.accessToken;
    } catch (e) {
      throw Exception('Register failed');
    }
  }
}
