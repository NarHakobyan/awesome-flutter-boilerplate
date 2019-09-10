import 'package:mobx/mobx.dart';

part 'data_state.g.dart';

class DataState = _DataState with _$DataState;

abstract class _DataState with Store {
  @observable
  bool loading = false;

  @observable
  bool hasData = false;

  @action
  void startLoading() {
    loading = true;
  }

  @action
  void stopLoading() {
    loading = false;
  }

  @action
  void dataFetched() {
    hasData = true;
  }
}
