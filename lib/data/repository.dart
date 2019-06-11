import 'dart:async';

import 'package:secure_chat/helpers/shared_preference_helper.dart';

import 'package:secure_chat/constants/db_constants.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:secure_chat/models/post_list/post_list.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:sembast/sembast.dart';
import 'local/datasources/post/post_datasource.dart';
import 'network/api/post/post_api.dart';

class Repository {
  // database object
  final _postDataSource = getIt<PostDataSource>();

  // api objects
  final _postApi = getIt<PostApi>();

  // shared pref object
  final _sharedPrefsHelper = getIt<SharedPreferenceHelper>();

  // Post: ---------------------------------------------------------------------
  Future<PostsList> getPosts() => _postApi.getPosts();

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
