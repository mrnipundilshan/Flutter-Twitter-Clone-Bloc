import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/repository/post_repository.dart';

class MockPostsRepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts({String? currentUserId}) async {
    return [
      PostEntity(
        userId: '1',
        username: 'nipun@123',
        content: 'nipun',
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<bool> createPost({required PostEntity post}) async {
    return true;
  }

  @override
  Future<bool> likePost({
    required String userId,
    required String postId,
  }) async {
    return true;
  }
}

class MockPostsWithErrorRepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts({String? currentUserId}) {
    throw Exception('Something Broke');
  }

  @override
  Future<bool> createPost({required PostEntity post}) async {
    throw Exception('Something Broke');
  }

  @override
  Future<bool> likePost({required String userId, required String postId}) {
    throw Exception('Something Broke');
  }
}
