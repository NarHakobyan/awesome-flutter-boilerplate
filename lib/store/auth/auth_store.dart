import 'package:mobx/mobx.dart';
import 'package:secure_chat/models/user/user.dart';

part 'auth_store.g.dart';

// This is the class used by rest of your codebase
class AuthStore = _AuthStore with _$AuthStore;

final authStoreState = AuthStore();

// The store-class
abstract class _AuthStore with Store {
  @observable
  User currentUser;

  @action
  void setCurrentUser(User user) {
    this.currentUser = user;
  }

  @action
  void changeUserName() {
    final draft = this.currentUser.clone()..firstName = 'Narek changed';

    this.currentUser = draft;
  }
}
