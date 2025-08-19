import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/create_post_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_state.dart';

import '../../data/repository/mock_posts_repository.dart';

void main() {
  group('FeedBloc test', () {
    late CreatePostBloc createPostBloc;
    late CreatePostBloc createPostBlocWithError;

    setUp(() {
      createPostBloc = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostsRepository(),
        ),
      );

      createPostBlocWithError = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostsWithErrorRepository(),
        ),
      );
    });

    blocTest(
      'emit [CreatedPostLoading, CreatedPostSuccess] when post are created successfully',
      build: () => createPostBloc,
      act: (bloc) => bloc.add(
        CreatePostRequested(
          username: 'nipun@123',
          content: 'best content',
          userId: '1234',
        ),
      ),
      expect: () => [CreatePostLoading(), isA<CreatePostSuccess>()],
    );

    blocTest(
      'emit [FeedLoading, FeedFailure] when loaded posts failed',
      build: () => createPostBlocWithError,
      act: (bloc) => bloc.add(
        CreatePostRequested(
          username: 'nipun@123',
          content: 'best content',
          userId: '1234',
        ),
      ),
      expect: () => [CreatePostLoading(), isA<CreatePostFailure>()],
    );
  });
}
