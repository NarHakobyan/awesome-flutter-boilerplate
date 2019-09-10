import 'package:mobx/mobx.dart';

part 'error_state.g.dart';

class ErrorState = _ErrorState with _$ErrorState;

abstract class _ErrorState with Store {
  @observable
  String error;

  bool get hasError {
    return error != null && error.isNotEmpty;
  }
}
