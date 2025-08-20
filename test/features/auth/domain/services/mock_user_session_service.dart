import 'package:flutter_twitter_clone_bloc/features/auth/data/datasources/session_local_data_source.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/services/user_session_service.dart';

class MockUserSessionService implements UserSessionService {
  @override
  Future<String?> getUserSession() async {
    return 'mock_token';
  }

  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> persistToken({required String token}) async {}

  @override
  SessionLocaDataSource get sessionLocalDataSource =>
      throw UnimplementedError();

  @override
  Future<void> getUserId() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserId({required String userId}) {
    // TODO: implement saveUserId
    throw UnimplementedError();
  }
}
