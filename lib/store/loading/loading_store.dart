import 'package:mobx/mobx.dart';

part 'loading_store.g.dart';

class LoadingStore = _LoadingStore with _$LoadingStore;

abstract class _LoadingStore with Store {
  @observable
  bool loading;

  @action
  void startLoading() {
    this.loading = true;
  }

  @action
  void stopLoading() {
    this.loading = false;
  }
}
