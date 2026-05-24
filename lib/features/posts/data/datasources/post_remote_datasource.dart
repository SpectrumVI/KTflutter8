import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  static const _postsAssetPath = 'assets/data/food_posts.json';
  PostRemoteDataSourceImpl();

  Future<List<PostModel>> _readPostsFromAsset() async {
    try {
      final raw = await rootBundle.loadString(_postsAssetPath);
      final parsed = jsonDecode(raw) as List<dynamic>;
      return parsed
          .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException('Failed to load local posts: $e');
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    return _readPostsFromAsset();
  }

  @override
  Future<PostModel> getPostById(int id) async {
    try {
      final posts = await _readPostsFromAsset();
      return posts.firstWhere((post) => post.id == id);
    } on StateError {
      throw CacheException('Post with id=$id not found in local json');
    } catch (e) {
      throw CacheException('Failed to load post by id: $e');
    }
  }
}
