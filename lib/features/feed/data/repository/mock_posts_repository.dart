import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/repository/post_repository.dart';

class MockPostsRepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts() async {
    return [
      PostEntity(
        userId: '1',
        username: 'nipun',
        content: 'nipun content',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '2',
        username: 'chamuditha',
        content: 'chamuditha content',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '3',
        username: 'dilru',
        content: 'dilru content',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '4',
        username: 'sena',
        content: 'sena content',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '5',
        username: 'sandu',
        content: 'sandu content',
        createdAt: DateTime.now(),
      ),
    ];
  }
}

class MockPostsWithErrorRepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts() {
    throw Exception('Something Broke');
  }
}
