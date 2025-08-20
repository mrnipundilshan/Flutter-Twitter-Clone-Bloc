import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/repository/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRespository implements PostRepository {
  final SupabaseClient client;
SupabasePostRespository({required this.client})

  @override
  Future<bool> createPost({required PostEntity post}) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> fetchPosts() async {
    try {
      final response = await client
      .from('posts')
      .select()
      .order('created_at', ascending: false);

      return(response as List).map((json){
            return
      })
    } catch (e) {
      throw Exception("Failed to fetch posts :$e");
    }
  }
}
