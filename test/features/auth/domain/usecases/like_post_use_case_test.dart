import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/like_post_use_case.dart';

import '../../../feed/data/repository/mock_posts_repository.dart';

void main() {
  group('LikePostUseCase', () {
    late MockPostsRepository mockPostsRepository;

    setUp(() {
      mockPostsRepository = MockPostsRepository();
    });

    test('Should like a post successfully', () async {
      LikePostUseCase likePostUseCase = LikePostUseCase(
        postRepository: mockPostsRepository,
      );

      final result = await likePostUseCase.call(
        postId: 'post_123',
        userId: '1234',
      );

      expect(result, isTrue);
    });
  });
}
