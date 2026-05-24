import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_bloc/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_bloc/features/posts/domain/entities/post.dart';

void main() {
  const tPostModel = PostModel(
    id: 1,
    userId: 1,
    title: 'Test title',
    body: 'Test body',
  );

  final tJson = {
    'id': 1,
    'userId': 1,
    'title': 'Test title',
    'body': 'Test body',
  };

  group('PostModel', () {
    test('should be a subclass of Post entity', () {
      expect(tPostModel, isA<Post>());
    });

    test('fromJson should return a valid PostModel', () {
      final result = PostModel.fromJson(tJson);
      expect(result, tPostModel);
    });

    test('toJson should return a valid JSON map', () {
      final result = tPostModel.toJson();
      expect(result, tJson);
    });
  });
}
