import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:secure_chat/store/data/data_state.dart';
import 'package:secure_chat/store/error/error_state.dart';
import 'package:secure_chat/utils/dio/dio_error_util.dart';

part 'post_state.g.dart';

class PostState = _PostState with _$PostState;

abstract class _PostState with Store {
  // store for handling errors
  final ErrorState error = ErrorState();
  final DataState dataState = DataState();

  // store variables:-----------------------------------------------------------
  @observable
  List<Post> posts;

  final PostRepository postRepository = GetIt.I<PostRepository>();

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPosts() async {
    dataState.startLoading();

    // TODO(narek): create mixin for this
    try {
      posts = await postRepository.getPosts();
      error.error = null;
    } on DioError catch (e) {
      error.error = DioErrorUtil.handleError(e);
    } finally {
      dataState
        ..dataFetched()
        ..stopLoading();
    }
  }
}
