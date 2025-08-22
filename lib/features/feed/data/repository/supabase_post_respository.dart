import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/repository/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRespository implements PostRepository {
  final SupabaseClient client;
  String postsTableName = 'posts';
  String likesTableName = 'likes';

  SupabasePostRespository({required this.client});

  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from(postsTableName).insert(data);
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

  @override
  Future<bool> likePost({
    required String userId,
    required String postId,
  }) async {
    try {
      final response = await client
          .from(postsTableName)
          .select('likes_count')
          .eq('id', postId)
          .single();

      final currentLikes = response['likes_count'] ?? 0;

      final existingLike = await client
          .from(likesTableName)
          .select()
          .eq('user_id', userId)
          .eq('post_id', postId)
          .maybeSingle();

      if (existingLike != null) {
        await client
            .from(likesTableName)
            .delete()
            .eq('user_id', userId)
            .eq('post_id', postId);

        await client
            .from(likesTableName)
            .update({'likes_count': currentLikes - 1})
            .eq('id', postId);
      } else {
        await client.from(likesTableName).insert({
          'user_id',
          userId,
          'post_id',
          postId,
        });
        await client
            .from(postsTableName)
            .update({'likes_count': currentLikes + 1})
            .eq('id', postId);
      }

      return true;
    } catch (e) {
      throw Exception('Failed to like post: $e');
    }
  }
}
