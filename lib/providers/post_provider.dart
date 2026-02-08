import 'package:flutter/material.dart';
import '../data/post_service.dart';
import '../models/post_model.dart';

enum PostStatus { loading, success, empty, error }

class PostProvider extends ChangeNotifier {
  final PostService service;

  PostProvider(this.service);

  PostStatus status = PostStatus.loading;
  List<PostModel> posts = [];
  String? errorMessage;

  Future<void> loadPosts({bool simulateEmpty = false}) async {
    status = PostStatus.loading;
    notifyListeners();

    try {
      final result = await service.getPosts();

      if (simulateEmpty) {
        posts = [];
      } else {
        posts = result;
      }

      if (posts.isEmpty) {
        status = PostStatus.empty;
      } else {
        status = PostStatus.success;
      }
    } catch (e) {
      status = PostStatus.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
