import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_shimmer.dart';
import 'post_detail_page.dart';
import '../../../../injection_container.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PostsBloc>()..add(const GetPostsEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Posts',
            style: TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          actions: [
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh_rounded, color: Color(0xFF6C63FF)),
                  onPressed: () {
                    context.read<PostsBloc>().add(const RefreshPostsEvent());
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading || state is PostsInitial) {
              return const LoadingShimmer();
            }

            if (state is PostsError) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<PostsBloc>().add(const GetPostsEvent());
                },
              );
            }

            if (state is PostsLoaded) {
              return RefreshIndicator(
                color: const Color(0xFF6C63FF),
                onRefresh: () async {
                  context.read<PostsBloc>().add(const RefreshPostsEvent());
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(
                      post: post,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostDetailPage(postId: post.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
