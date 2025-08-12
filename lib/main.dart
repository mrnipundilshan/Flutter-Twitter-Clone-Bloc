import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/data/repository/MockAuthRepository.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/register_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/bloc/register_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/screens/register_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Twitter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => RegisterBloc(
          registerUseCase: RegisterUseCase(
            authRepository: MockAuthRepository(),
          ),
        ),
        child: const RegisterPage(),
      ),
    );
  }
}
