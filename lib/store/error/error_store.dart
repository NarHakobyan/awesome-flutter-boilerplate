import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

class ErrorStore = _ErrorStore with _$ErrorStore;

abstract class _ErrorStore with Store {
  @observable
  String error;

  bool get hasError {
    return error != null && error.isNotEmpty;
  }
}
