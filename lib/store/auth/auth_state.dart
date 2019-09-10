import 'package:mobx/mobx.dart';
import 'package:secure_chat/models/user/user.dart';

part 'auth_state.g.dart';

// This is the class used by rest of your codebase
class AuthState = _AuthState with _$AuthState;

final AuthState authStateState = AuthState();

// The store-class
abstract class _AuthState with Store {
  @observable
  User currentUser;

  @action
  void setCurrentUser(User user) {
    currentUser = user;
  }

  @action
  void changeUserName() {
    final User draft = currentUser.clone()..firstName = 'Narek changed';

    currentUser = draft;
  }
}
