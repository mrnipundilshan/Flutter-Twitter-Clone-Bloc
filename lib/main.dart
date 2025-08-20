import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/data/datasources/session_local_data_source.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/data/repository/supabase_auth_repository.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/services/user_session_service.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/login/screens/login_page.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/presentation/register/screens/register_page.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/data/repository/supabase_post_respository.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/create_post_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/screens/feed_page.dart';
import 'package:flutter_twitter_clone_bloc/features/splash/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: 'url', anonKey: '');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final SessionLocaDataSource sessionLocalDataSource =
        SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(
      sessionLocalDataSource: sessionLocalDataSource,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: SupabaseAuthRepository(client: supabase),
            ),
            userSessionService: userSessionService,
          ),
        ),

        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(
              authRepository: SupabaseAuthRepository(client: supabase),
            ),
            userSessionService: userSessionService,
          ),
        ),

        BlocProvider(
          create: (_) => FeedBloc(
            fetchPostsUseCase: FetchPostsUseCase(
              postRepository: SupabasePostRespository(client: supabase),
            ),
          ),
        ),

        BlocProvider(
          create: (_) => CreatePostBloc(
            createPostUseCase: CreatePostUseCase(
              postRepository: SupabasePostRespository(client: supabase),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: "Twitter Demo",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        routes: {
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const FeedPage(),
        },
        home: SplashPage(userSessionService: userSessionService),
      ),
    );
  }
}
