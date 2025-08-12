import 'package:flutter_twitter_clone_bloc/features.auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> register({required UserEntity user});
}
