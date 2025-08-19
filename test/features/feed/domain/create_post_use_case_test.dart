import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/create_post_use_case.dart';

import '../data/repository/mock_posts_repository.dart';

void main() {
  group('CreatePostUseCase', () {
    late MockPostsRepository mockPostsRepository;
    late MockPostsWithErrorRepository mockPostsWithErrorRepository;

    setUp(() {
      mockPostsRepository = MockPostsRepository();
      mockPostsWithErrorRepository = MockPostsWithErrorRepository();
    });

    test('Should create a post successfully', () async {
      String userId = "1234";
      String username = "fabrice";
      String content = "best flutter content";
      String imageUrl = "";

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostsRepository,
      );

      final result = await createPostUseCase.call(
        userId: userId,
        username: username,
        content: content,
        imageUrl: imageUrl,
      );

      expect(result, isTrue);
    });

    test('Should return an error if username or content are empty', () async {
      String userId = "1234";
      String username = "";
      String content = "";
      String imageUrl = "";

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostsRepository,
      );

      expect(
        () async => await createPostUseCase.call(
          userId: userId,
          username: username,
          content: content,
          imageUrl: imageUrl,
        ),
        throwsA(isA<Exception>),
      );
    });
  });
}
