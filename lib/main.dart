import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/data/repository/MockAuthRepository.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/login_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/domain/usecases/register_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/screens/login_page.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/register/screens/register_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: MockAuthRepository(),
            ),
          ),
        ),

        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: MockAuthRepository()),
          ),
        ),
      ],
      child: MaterialApp(
        title: "Twitter Demo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/login',
        routes: {
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
        home: RegisterPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Nipun is Logged')));
  }
}
