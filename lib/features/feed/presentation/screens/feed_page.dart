import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/feed/feed_state.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/presentation/bloc/post/create_post_state.dart';
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
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(backgroundColor: Colors.grey[800]),
        ),
        centerTitle: true,
        title: Image.asset('assets/twitter.png', width: 32, height: 32),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.mail, color: Colors.white),
          ),
        ],
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        backgroundColor: Colors.blue,
        child: const Icon(CupertinoIcons.add, color: Colors.white),
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<CreatePostBloc, CreatePostState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Create Post'),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: "What's happening",
                  ),
                  maxLines: 5,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Content is required'
                      : null,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: state is CreatePostLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreatePostBloc>().add(
                              CreatePostRequested(
                                username: '1234',

                                userId: 'nipun@123',
                                content: contentController.text.trim(),
                                imageUrl: '',
                              ),
                            );
                          }
                        },
                  child: state is CreatePostLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Post'),
                ),
              ],
            );
          },
          listener: (contetn, state) {
            if (state is CreatePostSuccess) {
              Navigator.pop(context);
              context.read<FeedBloc>().add(FetchPostsRequested());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Post created")));
            }
            if (state is CreatePostFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        );
      },
    );
  }
}
