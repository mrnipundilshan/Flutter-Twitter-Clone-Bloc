import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features/auth/domain/services/user_session_service.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/like_post_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FetchPostsUseCase fetchPostsUseCase;
  LikePostUseCase likePostUseCase;
  UserSessionService userSessionService;

  FeedBloc({
    required this.fetchPostsUseCase,
    required this.likePostUseCase,
    required this.userSessionService,
  }) : super(FeedInitial()) {
    on<FetchPostsRequested>(_fetchPostsRequested);
    on<LikePostRequested>(_likePostRequested);
  }

  _fetchPostsRequested(
    FetchPostsRequested event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final session = await userSessionService.getUserSession();
      final posts = await fetchPostsUseCase.call(currentUserId: session?.id);
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedFailure(message: formatError(e)));
    }
  }

  FutureOr<void> _likePostRequested(
    LikePostRequested event,
    Emitter<FeedState> emit,
  ) async {
    try {
      await likePostUseCase.call(userId: event.userId, postId: event.postId);
      add(FetchPostsRequested());
    } catch (e) {
      emit(FeedFailure(message: formatError(e)));
    }
  }
}
