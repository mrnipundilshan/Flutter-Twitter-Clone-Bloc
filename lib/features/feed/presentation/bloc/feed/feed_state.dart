import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';

abstract class FeedState extends Equatable {
  @override
  List<Object> get props => [];
}

final class FeedInitial extends FeedState {}

final class FeedLoading extends FeedState {}

final class FeedLoaded extends FeedState {
  final List<PostEntity> posts;

  FeedLoaded({required this.posts});
}

final class FeedFailure extends FeedState {
  final String message;

  FeedFailure({required this.message});
}
