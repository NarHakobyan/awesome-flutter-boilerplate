import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/db_constants.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:sembast/sembast.dart';

class PostDataSource {
  final _postsStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  Future<Database> _getDatabase() async => await GetIt.I<AppDatabase>().getDatabase();

  Future<int> insert(Post post) async {
    return await _postsStore.add(await _getDatabase(), post.toJson());
  }

  Future<int> update(Post post) async {
    return await _postsStore.update(
      await _getDatabase(),
      post.toJson(),
      finder: Finder(filter: Filter.byKey(post.id)),
    );
  }

  Future<int> delete(Post post) async {
    return await _postsStore.delete(
      await _getDatabase(),
      finder: Finder(filter: Filter.byKey(post.id)),
    );
  }

  Future deleteAll() async {
    await _postsStore.drop(
      await _getDatabase(),
    );
  }

  Future<List<Post>> getAllSortedByFilter({List<Filter> filters}) async {
    final finder = Finder(
        filter: Filter.and(filters),
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _postsStore.find(
      await _getDatabase(),
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final post = Post.fromJson(snapshot.value);
      post.id = snapshot.key;
      return post;
    }).toList();
  }

  Future<List<Post>> getAllPosts() async {
    final recordSnapshots = await _postsStore.find(
      await _getDatabase(),
    );

    return recordSnapshots.map((snapshot) {
      final post = Post.fromJson(snapshot.value);
      post.id = snapshot.key;
      return post;
    }).toList();
  }
}
