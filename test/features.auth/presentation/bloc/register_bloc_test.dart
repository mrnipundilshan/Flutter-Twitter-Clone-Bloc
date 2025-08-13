import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_state.dart';

import '../../data/repository/MockAuthRepository.dart';
import '../../domain/services/mock_user_session_service.dart';

void main() {
  group('RegisterBloc test', () {
    late RegisterBloc registerBloc;
    late RegisterBloc registerBlocWithRepositoryError;
    MockUserSessionService mockUserSessionService = MockUserSessionService();

    setUp(() {
      registerBloc = RegisterBloc(
        registerUseCase: RegisterUseCase(authRepository: MockAuthRepository()),
        userSessionService: mockUserSessionService,
      );
      registerBlocWithRepositoryError = RegisterBloc(
        registerUseCase: RegisterUseCase(
          authRepository: MockAuthWithErrorRepository(),
        ),
        userSessionService: mockUserSessionService,
      );
    });

    blocTest(
      'emit [RegisterLoading, RegisterSuccess] when register is successful',
      build: () => registerBloc,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'nipun@gmail.com',
          username: 'nipun@123',
          password: '12345',
        ),
      ),
      expect: () => [RegisterLoading(), RegisterSuccess()],
    );
    blocTest(
      'emit [RegisterLoading, RegisterFailure] when email is wrong',
      build: () => registerBloc,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'nipun',
          username: 'nipun@123',
          password: '12345',
        ),
      ),
      expect: () => [RegisterLoading(), isA<RegisterFailure>()],
    );

    blocTest(
      'emit [RegisterLoading, RegisterFailure] when repository return an error',
      build: () => registerBlocWithRepositoryError,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: 'nipun@gmail.com',
          username: 'nipun@123',
          password: '12345',
        ),
      ),
      expect: () => [RegisterLoading(), isA<RegisterFailure>()],
    );
  });
}
