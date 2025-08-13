import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';

import '../data/repository/mock_posts_repository.dart';

void main() {
  group('FetchFeedUseCase test', () {
    test('Should return list of posts', () async {
      MockPostsRepository mockPostsRepository = MockPostsRepository();
      FetchPostsUseCase fetchPostUseCase = FetchPostsUseCase(
        postRepository: mockPostsRepository,
      );

      final result = await fetchPostUseCase.call();

      expect(result, isA<List<PostEntity>>());
      expect(result.length, greaterThan(0));
    });
  });
}
