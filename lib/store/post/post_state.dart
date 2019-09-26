import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:secure_chat/store/error/error_state.dart';
import 'package:secure_chat/store/loading/loading_state.dart';
import 'package:secure_chat/utils/dio/dio_error_util.dart';

part 'post_state.g.dart';

class PostState = _PostState with _$PostState;

abstract class _PostState with Store {
  final ErrorState error = ErrorState();
  final LoadingState loadingState = LoadingState();

  // store variables:-----------------------------------------------------------
  List<Post> posts;

  @observable
  ObservableFuture<List<Post>> fetchPostsFuture = ObservableFuture.value([]);

  @computed
  bool get hasResults =>
      fetchPostsFuture != emptyPosts &&
      fetchPostsFuture.status == FutureStatus.fulfilled;

  final PostRepository postRepository = GetIt.I<PostRepository>();

  static ObservableFuture<List<Post>> emptyPosts = ObservableFuture.value([]);

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPosts() async {
    loadingState.startLoading();

    // TODO(narek): create mixin for this
    try {
      final future = postRepository.getPosts();
      fetchPostsFuture = ObservableFuture(future);

      posts = await future;
      error.error = null;
    } on DioError catch (e) {
      error.error = DioErrorUtil.handleError(e);
    } finally {
      loadingState.stopLoading();
    }
  }
}
