import 'package:flutter_twitter_clone_bloc/features/auth/data/datasources/session_loca_data_source.dart';

class UserSessionServices {
  final SessionLocaDataSource sessionLocalDataSource;

  UserSessionServices({required this.sessionLocalDataSource});

  Future<void> saveUserSession({required String token}) async {
    return sessionLocalDataSource.saveToken(token: token);
  }

  Future<void> getUserSession() {
    return sessionLocalDataSource.getToken();
  }

  Future<void> clearUserSession() {
    return sessionLocalDataSource.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await sessionLocalDataSource.getToken();
    return token != null && token.isNotEmpty;
  }
}
