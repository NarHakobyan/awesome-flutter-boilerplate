import 'package:mobx/mobx.dart';
import 'package:secure_chat/models/user/user.dart';

part 'auth_store.g.dart';

// This is the class used by rest of your codebase
class AuthStore = _AuthStore with _$AuthStore;

final AuthStore authStoreState = AuthStore();

// The store-class
abstract class _AuthStore with Store {
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
