import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone_bloc/core/utils.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Top row : avatr + username + timestamp
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(radius: 20, backgroundColor: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          post.username,
                        ),
                        const SizedBox(height: 10),
                        const Spacer(),
                        Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          formatDate(post.createdAt),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      post.content * 40,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (post.imageUrl != null && post.imageUrl!.isEmpty) ...[
            const SizedBox(height: 12),
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
              const Icon(Icons.share, color: Colors.grey, size: 20),
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
        Text(
          '${count ?? 0}',
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}
