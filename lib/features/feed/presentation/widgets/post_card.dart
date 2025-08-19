import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                post.username,
              ),
              const SizedBox(height: 10),
              Text(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                formatDate(post.createdAt),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            post.content,
          ),

          if (post.imageUrl != null && post.imageUrl!.isEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.network(post.imageUrl!),
            ),
          ],
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _postStat(icon: Icons.favorite_border, count: post.likesCount),
              _postStat(icon: Icons.favorite_border, count: post.commentsCount),
              _postStat(icon: Icons.favorite_border, count: post.repostsCount),
            ],
          ),
        ],
      ),
    );
  }
}

class _postStat extends StatelessWidget {
  final IconData icon;
  final int? count;
  const _postStat({super.key, required this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        SizedBox(width: 10),
        Text('${count ?? 0}', style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
