import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPosts();
}
