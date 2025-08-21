import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_session_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/models/LoginParams.dart';

abstract class AuthRepository {
  Future<UserSessionEntity> register({required UserEntity user});
  Future<UserSessionEntity> login({required LoginParams loginParams});
}
