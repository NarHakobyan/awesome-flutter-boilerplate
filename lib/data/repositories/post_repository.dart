import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/db_constants.dart';
import 'package:secure_chat/data/datasources/post/post_datasource.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:secure_chat/models/post_list/post_list.dart';
import 'package:sembast/sembast.dart';


class PostRepository {
  // database object
  final _postDataSource = GetIt.I<PostDataSource>();
  final _dioClient = GetIt.I<Dio>();

  // Post: ---------------------------------------------------------------------
  Future<PostsList> getPosts() {
    return _dioClient
        .get<dynamic>('/posts')
        .then((res) => PostsList.fromJson(res.data));
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = List();

    //check to see if dataLogsType is not null
    if (id != null) {
      Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
      filters.add(dataLogTypeFilter);
    }

    return _postDataSource.getAllSortedByFilter(filters: filters);
  }

  Future<int> insert(Post post) => _postDataSource.insert(post);

  Future<int> update(Post post) => _postDataSource.update(post);

  Future<int> delete(Post post) => _postDataSource.delete(post);
}
