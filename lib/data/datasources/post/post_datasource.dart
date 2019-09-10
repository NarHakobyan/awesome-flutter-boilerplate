import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/db_constants.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:sembast/sembast.dart';

class PostDataSource {
  final StoreRef<int, Map<String, dynamic>> _postsStore = intMapStoreFactory.store(DBConstants.storeName);

  Future<Database> _getDatabase() async => GetIt.I<AppDatabase>().getDatabase();

  Future<int> insert(Post post) async {
    return _postsStore.add(await _getDatabase(), post.toJson());
  }

  Future<int> update(Post post) async {
    return _postsStore.update(
      await _getDatabase(),
      post.toJson(),
      finder: Finder(filter: Filter.byKey(post.id)),
    );
  }

  Future<int> delete(Post post) async {
    return _postsStore.delete(
      await _getDatabase(),
      finder: Finder(filter: Filter.byKey(post.id)),
    );
  }

  Future<void> deleteAll() async {
    await _postsStore.drop(
      await _getDatabase(),
    );
  }

  Future<List<Post>> getAllSortedByFilter({List<Filter> filters}) async {
    final Finder finder = Finder(
        filter: Filter.and(filters),
        sortOrders: <SortOrder>[SortOrder(DBConstants.idFieldName)]);

    final List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots = await _postsStore.find(
      await _getDatabase(),
      finder: finder,
    );

    return recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
      return Post.fromJson(snapshot.value)
        ..id = snapshot.key;
    }).toList();
  }

  Future<List<Post>> getAllPosts() async {
    final List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots = await _postsStore.find(
      await _getDatabase(),
    );

    return recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
      return Post.fromJson(snapshot.value)
      ..id = snapshot.key;
    }).toList();
  }
}
