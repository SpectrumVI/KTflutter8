import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_bloc/core/error/failures.dart';
import 'package:flutter_clean_bloc/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_bloc/features/posts/domain/usecases/get_posts.dart';
import 'package:flutter_clean_bloc/features/posts/presentation/bloc/posts_bloc.dart';

class MockGetPosts extends Mock implements GetPosts {}

void main() {
  late PostsBloc bloc;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    bloc = PostsBloc(getPosts: mockGetPosts);
  });

  tearDown(() => bloc.close());

  const tPosts = [
    Post(id: 1, userId: 1, title: 'Test Title', body: 'Test Body'),
  ];

  group('PostsBloc', () {
    test('initial state is PostsInitial', () {
      expect(bloc.state, isA<PostsInitial>());
    });

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoading, PostsLoaded] when GetPostsEvent is added and succeeds',
      build: () {
        when(mockGetPosts(any)).thenAnswer((_) async => const Right(tPosts));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [
        isA<PostsLoading>(),
        isA<PostsLoaded>(),
      ],
    );

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoading, PostsError] when GetPostsEvent fails',
      build: () {
        when(mockGetPosts(any)).thenAnswer(
          (_) async => const Left(ServerFailure('Server error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [
        isA<PostsLoading>(),
        isA<PostsError>(),
      ],
    );
  });
}
