part of 'post_detail_bloc.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object> get props => [];
}

class GetPostByIdEvent extends PostDetailEvent {
  final int id;
  const GetPostByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
