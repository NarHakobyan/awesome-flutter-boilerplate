import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_state.g.dart';

// This is the class used by rest of your codebase
class LoginState = _LoginState with _$LoginState;

final LoginState loginStateState = LoginState();

// The store-class
abstract class _LoginState with Store {
  @observable
  bool rememberMe = false;

  @action
  void setRememberMe({@required bool rememberMe}) {
    this.rememberMe = rememberMe;
  }
}
