import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/models/LoginParams.dart';

abstract class AuthRepository {
  Future<String> register({required UserEntity user});
  Future<String> login({required LoginParams loginParams});
}
