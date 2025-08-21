import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/entities/user_session_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/usecases/login_use_case.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group('LoginUseCase test', () {
    late LoginUseCase loginUseCase;

    setUp(() {
      loginUseCase = LoginUseCase(authRepository: MockAuthRepository());
    });

    test('Should login user successfully and return token', () async {
      final String email = "nipun@gmail.com";
      final String password = "nipun@123";

      final result = await loginUseCase.call(email: email, password: password);

      expect(result, isA<UserSessionEntity>());
      expect(result.email, email);
      expect(result.token, 'token');
    });

    test('Should return error with empty email', () async {
      final String email = "";
      final String password = "nipun@123";

      expect(
        () async => await loginUseCase.call(email: email, password: password),

        throwsA(isA<Exception>()),
      );
    });

    test('Should return error with both Empty fileds', () async {
      final String email = "";
      final String password = "";

      expect(
        () async => await loginUseCase.call(email: email, password: password),

        throwsA(isA<Exception>()),
      );
    });
  });
}
