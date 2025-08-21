import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_session_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/models/LoginParams.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    return UserSessionEntity(id: '123', email: user.email, token: 'token');
  }

  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) async {
    return UserSessionEntity(
      id: '123',
      email: loginParams.email,
      token: 'token',
    );
  }
}

class MockAuthWithErrorRepository implements AuthRepository {
  @override
  Future<UserSessionEntity> register({required UserEntity user}) async {
    throw Exception('Registration failed');
  }

  @override
  Future<UserSessionEntity> login({required LoginParams loginParams}) {
    throw Exception('Login Failed');
  }
}
