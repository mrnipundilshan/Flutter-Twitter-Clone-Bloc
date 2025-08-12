import 'package:flutter_twitter_clone_bloc/features.auth/domain/entities/user_entity.dart';

class RegisterUseCase {
  Future<String> call({
    required String email,
    required String username,
    required String password,
  }) async {
    final user = UserEntity(
      email: email,
      username: username,
      password: password,
    );
    return 'token'; //repository.register()
  }
}
