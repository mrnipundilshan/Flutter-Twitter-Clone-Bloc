import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_state.dart';

import '../../data/repository/mock_posts_repository.dart';

void main() {
  group('FeedBloc test', () {
    late FeedBloc feedBloc;
    late FeedBloc feedBlocWithError;

    setUp(() {
      feedBloc = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostsRepository(),
        ),
      );
      feedBlocWithError = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostsWithErrorRepository(),
        ),
      );
    });

    blocTest(
      'emit [FeedLoading, FeedSuccess] when post are fetched successfully',
      build: () => feedBloc,
      act: (bloc) => bloc.add(FetchPostsRequested()),
      expect: () => [FeedLoading(), isA<FeedLoaded>()],
    );

    blocTest(
      'emit [FeedLoading, FeedFailure] when loaded posts failed',
      build: () => feedBlocWithError,
      act: (bloc) => bloc.add(FetchPostsRequested()),
      expect: () => [FeedLoading(), isA<FeedFailure>()],
    );
  });
}
