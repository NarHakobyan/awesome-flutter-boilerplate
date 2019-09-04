import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/models/post_list/post_list.dart';
import 'package:secure_chat/store/error/error_store.dart';
import 'package:secure_chat/store/loading/loading_store.dart';
import 'package:secure_chat/utils/dio/dio_error_util.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final LoadingStore loadingStore = LoadingStore();

  // store variables:-----------------------------------------------------------
  @observable
  PostsList postsList;

  final PostRepository postRepository = GetIt.I<PostRepository>();

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPosts() async {
    loadingStore.loading = true;

    try {
      postsList = await postRepository.getPosts();
      errorStore.error = null;
    } catch (e) {
      errorStore.error = DioErrorUtil.handleError(e);
    } finally {
      loadingStore.loading = false;
    }
  }
}
