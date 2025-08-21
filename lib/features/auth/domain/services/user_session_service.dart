import 'package:flutter_twitter_clone_bloc/features/auth/data/datasources/session_local_data_source.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_session_entity.dart';

class UserSessionService {
  final SessionLocaDataSource sessionLocalDataSource;

  UserSessionService({required this.sessionLocalDataSource});

  Future<void> persistSession({required UserSessionEntity userSession}) async {
    await sessionLocalDataSource.saveSession(session: userSession);
  }

  Future<UserSessionEntity?> getUserSession() {
    return sessionLocalDataSource.getSession();
  }

  Future<void> logout() {
    return sessionLocalDataSource.clearSession();
  }

  Future<bool> isLoggedIn() async {
    final session = await sessionLocalDataSource.getSession();
    return session != null && session.token.isNotEmpty;
  }
}
