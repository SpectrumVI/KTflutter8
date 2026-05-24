import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostById implements UseCase<Post, PostParams> {
  final PostRepository repository;

  GetPostById(this.repository);

  @override
  Future<Either<Failure, Post>> call(PostParams params) {
    return repository.getPostById(params.id);
  }
}

class PostParams extends Equatable {
  final int id;
  const PostParams({required this.id});

  @override
  List<Object> get props => [id];
}
