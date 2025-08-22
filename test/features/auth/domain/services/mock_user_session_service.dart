import 'package:flutter_twitter_clone_bloc/features/auth/data/datasources/session_local_data_source.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_session_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/services/user_session_service.dart';

class MockUserSessionService implements UserSessionService {
  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> logout() async {}

  @override
  SessionLocaDataSource get sessionLocalDataSource =>
      throw UnimplementedError();

  @override
  Future<UserSessionEntity?> getUserSession() async {
    return UserSessionEntity(
      id: '123',
      email: 'nipun@gmail.com',
      token: 'token',
    );
  }

  @override
  Future<void> persistSession({required UserSessionEntity userSession}) async {}
}
