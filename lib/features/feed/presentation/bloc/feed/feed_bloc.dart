import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FetchPostsUseCase fetchPostsUseCase;

  FeedBloc({required this.fetchPostsUseCase}) : super(FeedInitial()) {
    on<FetchPostsRequested>(_fetchPostsRequested);
  }

  _fetchPostsRequested(
    FetchPostsRequested event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      //await Future.delayed(const Duration(seconds: 2));
      final posts = await fetchPostsUseCase.call();
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedFailure(message: formatError(e)));
    }
  }
}
