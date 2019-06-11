import 'package:mobx/mobx.dart';
import 'package:secure_chat/data/network/api/post/post_api.dart';
import 'package:secure_chat/data/repository.dart';
import 'package:secure_chat/models/post_list/post_list.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/store/error/error_store.dart';
import 'package:secure_chat/utils/dio/dio_error_util.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  PostsList postsList;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  final postApi = getIt<PostApi>();

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {
    loading = true;

    try {
      this.postsList = await postApi.getPosts();
      success = true;
      errorStore.showError = false;
    } catch (e) {
      success = false;
      errorStore.errorMessage = DioErrorUtil.handleError(e);
      errorStore.showError = true;
    } finally {
      loading = false;
    }
  }
}
