import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';
import '../../../../core/usecases/usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts getPosts;

  PostsBloc({required this.getPosts}) : super(PostsInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<RefreshPostsEvent>(_onRefreshPosts);
  }

  Future<void> _onGetPosts(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());
    final result = await getPosts(NoParams());
    result.fold(
      (failure) => emit(PostsError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }

  Future<void> _onRefreshPosts(
    RefreshPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());
    final result = await getPosts(NoParams());
    result.fold(
      (failure) => emit(PostsError(failure.message)),
      (posts) => emit(PostsLoaded(posts)),
    );
  }
}
