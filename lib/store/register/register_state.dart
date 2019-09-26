import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/store/auth/auth_state.dart';
import 'package:secure_chat/store/error/error_state.dart';
import 'package:secure_chat/store/loading/loading_state.dart';

part 'register_state.g.dart';

// This is the class used by rest of your codebase
class RegisterState = _RegisterState with _$RegisterState;

// The store-class
abstract class _RegisterState with Store {
  final loadingState = LoadingState();
  final errorState = ErrorState();
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  @observable
  bool rememberMe = false;

  // actions:-------------------------------------------------------------------
  @action
  Future<User> registerUser(Map<String, dynamic> data) async {
    loadingState.startLoading();

    try {
      final user = await authRepository.registerUser(data);

      GetIt.I<AuthState>().setCurrentUser(user);

      errorState.error = null;
      return user;
    } finally {
      loadingState.stopLoading();
    }
  }
}
