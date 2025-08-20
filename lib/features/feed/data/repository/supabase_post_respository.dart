import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/repository/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRespository implements PostRepository {
  final SupabaseClient client;
  String tableName = 'posts';

  SupabasePostRespository({required this.client});

  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from(tableName).insert(data);
      return true;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  @override
  Future<List<PostEntity>> fetchPosts() async {
    try {
      final response = await client
          .from('posts')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) {
        return PostEntity.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch posts :$e");
    }
  }
}
