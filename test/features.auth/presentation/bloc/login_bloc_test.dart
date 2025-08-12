import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/login_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_state.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group('LoginBloc test', () {
    late LoginBloc loginBloc;
    late LoginBloc loginBlocWithRepositoryError;

    setUp(() {
      loginBloc = LoginBloc(
        loginUseCase: LoginUseCase(authRepository: MockAuthRepository()),
      );
      loginBlocWithRepositoryError = LoginBloc(
        loginUseCase: LoginUseCase(
          authRepository: MockAuthWithErrorRepository(),
        ),
      );
    });

    blocTest(
      'emit [LoginLoading, LoginSuccess] when login is successfull',
      build: () => loginBloc,
      act: (bloc) =>
          bloc.add(LoginSubmitted(email: 'nipun@gmail.com', password: '12345')),
      expect: () => [LoginLoading(), LoginSuccess()],
    );

    blocTest(
      'emit [LoginLoading, LoginFailure] when password is wrong',
      build: () => loginBloc,
      act: (bloc) =>
          bloc.add(LoginSubmitted(email: 'nipun@gmail.com', password: '0')),
      expect: () => [LoginLoading(), isA<LoginFailure>()],
    );

    blocTest(
      'emit [LoginLoading, LoginFailure] when repository return an error',
      build: () => loginBlocWithRepositoryError,
      act: (bloc) =>
          bloc.add(LoginSubmitted(email: 'nipun@gmail.com', password: '12345')),
      expect: () => [LoginLoading(), isA<LoginFailure>()],
    );
  });
}
