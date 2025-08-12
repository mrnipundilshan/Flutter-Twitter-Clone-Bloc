import 'package:flutter_twitter_clone_bloc/features.auth/domain/entities/user_entity.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<String> register({required UserEntity user}) async {
    return 'token';
  }
}

class MockAuthWithErrorRepository implements AuthRepository {
  @override
  Future<String> register({required UserEntity user}) async {
    throw Exception('Registration failed');
  }
}
