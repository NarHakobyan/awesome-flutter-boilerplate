import 'package:mobx/mobx.dart';

part 'loading_state.g.dart';

class LoadingState = _LoadingState with _$LoadingState;

abstract class _LoadingState with Store {
  @observable
  bool loading = false;

  @action
  void startLoading() {
    loading = true;
  }

  @action
  void stopLoading() {
    loading = false;
  }
}
