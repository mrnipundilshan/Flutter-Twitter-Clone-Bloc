import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/entities/post_entity.dart';
import 'package:flutter_twitter_clone_bloc/features/feed/domain/usecases/fetch_posts_use_case.dart';

import '../data/repository/mock_posts_repository.dart';

void main() {
  group('FetchFeedUseCase test', () {
    late MockPostsRepository mockPostsRepository;
    late MockPostsWithErrorRepository mockPostsWithErrorRepository;

    setUp(() {
      mockPostsRepository = MockPostsRepository();
      mockPostsWithErrorRepository = MockPostsWithErrorRepository();
    });

    test('Should return list of posts', () async {
      FetchPostsUseCase fetchPostsUseCase = FetchPostsUseCase(
        postRepository: mockPostsRepository,
      );

      final result = await fetchPostsUseCase.call();

      expect(result, isA<List<PostEntity>>());
      expect(result.length, greaterThan(0));
    });

    test('Should return an error if repository is compromise', () async {
      FetchPostsUseCase fetchPostUseCase = FetchPostsUseCase(
        postRepository: mockPostsWithErrorRepository,
      );

      expect(
        () async => await fetchPostUseCase.call(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
