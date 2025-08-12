import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/login/bloc/login_state.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features.auth/presentation/register/bloc/register_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    context.read<LoginBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, './home');
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
          },

          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _onLoginPressed,
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  if (state is LoginFailure)
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (state is LoginSuccess)
                    Text(
                      "Login successfully!",
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
