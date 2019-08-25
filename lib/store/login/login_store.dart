import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// This is the class used by rest of your codebase
class LoginStore = _LoginStore with _$LoginStore;

final loginStoreState = LoginStore();

// The store-class
abstract class _LoginStore with Store {
  @observable
  bool rememberMe = false;

  @action
  setRememberMe({@required bool rememberMe}) {
    this.rememberMe = rememberMe;
  }
}
