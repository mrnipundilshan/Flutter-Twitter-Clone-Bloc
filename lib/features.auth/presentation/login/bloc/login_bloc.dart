import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/login_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, emit) async {
    emit(LoginLoading());
    try {
      await loginUseCase.call(email: event.email, password: event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: formatError(e)));
    }
  }
}
