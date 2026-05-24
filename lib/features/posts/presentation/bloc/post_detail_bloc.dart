import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post_by_id.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final GetPostById getPostById;

  PostDetailBloc({required this.getPostById}) : super(PostDetailInitial()) {
    on<GetPostByIdEvent>(_onGetPostById);
  }

  Future<void> _onGetPostById(
    GetPostByIdEvent event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(PostDetailLoading());
    final result = await getPostById(PostParams(id: event.id));
    result.fold(
      (failure) => emit(PostDetailError(failure.message)),
      (post) => emit(PostDetailLoaded(post)),
    );
  }
}
