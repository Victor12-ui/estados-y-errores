import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostService {
  final Dio dio;

  PostService(this.dio);

  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('/posts');

    final data = response.data as List;

    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
