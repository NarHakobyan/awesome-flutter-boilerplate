import 'dart:async';

import 'package:dio/dio.dart';
import 'package:secure_chat/models/post_list/post_list.dart';
import 'package:secure_chat/providers/get_it.dart';

class PostApi {
  final _dioClient = getIt<Dio>();

  Future<PostsList> getPosts() {
    return _dioClient
        .get<dynamic>('/posts')
        .then((res) => PostsList.fromJson(res.data));
  }
}
