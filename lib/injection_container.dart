import 'package:get_it/get_it.dart';

import 'features/posts/data/datasources/post_remote_datasource.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/domain/usecases/get_post_by_id.dart';
import 'features/posts/domain/usecases/get_posts.dart';
import 'features/posts/presentation/bloc/post_detail_bloc.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(() => PostsBloc(getPosts: sl()));
  sl.registerFactory(() => PostDetailBloc(getPostById: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => GetPostById(sl()));

  // Repositories
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(),
  );
}
