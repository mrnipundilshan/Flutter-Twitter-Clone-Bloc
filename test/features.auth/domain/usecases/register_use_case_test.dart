import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/register_use_case.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group('RegisterUseCase test', () {
    test('Should register user succussfully and return token', () async {
      final String email = "nipun@gmail.com";
      final String username = "nipun@123";
      final String password = "nipun@123";

      RegisterUseCase registerUseCase = RegisterUseCase(
        authRepository: MockAuthRepository(),
      );
      final result = await registerUseCase.call(
        email: email,
        username: username,
        password: password,
      );
      expect(result, 'token');
    });

    test('Should return an error with empty email', () async {
      final String email = "";
      final String username = "nipun@123";
      final String password = "nipun@123";

      RegisterUseCase registerUseCase = RegisterUseCase(
        authRepository: MockAuthRepository(),
      );
      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return an error with empty username', () async {
      final String email = "nipun@gmail.com";
      final String username = "";
      final String password = "nipun@123";

      RegisterUseCase registerUseCase = RegisterUseCase(
        authRepository: MockAuthRepository(),
      );
      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return an error if email have wrong format', () async {
      final String email = "fgdrfgfg";
      final String username = "nipun@123";
      final String password = "nipun@123";

      RegisterUseCase registerUseCase = RegisterUseCase(
        authRepository: MockAuthRepository(),
      );
      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test(
      'Should return an error if password do not at least 5 characters',
      () async {
        final String email = "";
        final String username = "nipun@123";
        final String password = "nip";

        RegisterUseCase registerUseCase = RegisterUseCase(
          authRepository: MockAuthRepository(),
        );
        expect(
          () async => await registerUseCase.call(
            email: email,
            username: username,
            password: password,
          ),
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
