import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/services/user_session_service.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;
  UserSessionService userSessionService;

  RegisterBloc({
    required this.registerUseCase,
    required this.userSessionService,
  }) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, emit) async {
    emit(RegisterLoading());
    try {
      final token = await registerUseCase.call(
        email: event.email,
        username: event.username,
        password: event.password,
      );
      await userSessionService.persistSession(userSession: token);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(message: formatError(e)));
    }
  }
}
