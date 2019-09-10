import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/db_constants.dart';
import 'package:secure_chat/data/datasources/post/post_datasource.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:sembast/sembast.dart';


class PostRepository {
  // database object
  final PostDataSource _postDataSource = GetIt.I<PostDataSource>();
  final Dio _dioClient = GetIt.I<Dio>();

  // Post: ---------------------------------------------------------------------
  Future<List<Post>> getPosts() {
    final List<Map<String, dynamic>> items = <Map<String, dynamic>>[
      <String, dynamic>{
      'id': 1,
      'userId': 1,
      'title': 'title',
      'body': 'body'
    }];

    final List<Post> posts = items.map<Post>((Map<String, dynamic> item) => Post.fromJson(item)).toList();
    return Future<List<Post>>.value(posts);
//    return _dioClient
//        .get<dynamic>('/posts')
//        .then((Response<dynamic> res) => PostsList.fromJson(res.data));
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    final List<Filter> filters = <Filter>[];

    //check to see if dataLogsType is not null
    if (id != null) {
      final Filter dataLogTypeFilter = Filter.equals(DBConstants.idFieldName, id);
      filters.add(dataLogTypeFilter);
    }

    return _postDataSource.getAllSortedByFilter(filters: filters);
  }

  Future<int> insert(Post post) => _postDataSource.insert(post);

  Future<int> update(Post post) => _postDataSource.update(post);

  Future<int> delete(Post post) => _postDataSource.delete(post);
}
