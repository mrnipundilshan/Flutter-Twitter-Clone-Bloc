import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_state.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    context.read<FeedBloc>().add(FetchPostsRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            final posts = state.posts;
            if (posts.isEmpty) {
              return const Center(child: Text('No Posts found'));
            }
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostCard(post: posts[index]),
            );
          } else if (state is FeedFailure) {
            return Center(child: Text('Error : ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
