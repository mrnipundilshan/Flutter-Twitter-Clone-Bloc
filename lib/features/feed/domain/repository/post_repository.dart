import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPosts();
  Future<bool> createPost({required PostEntity post});
  Future<bool> likePost({required String userId, required String postId});
}
