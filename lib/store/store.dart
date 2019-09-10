import 'package:get_it/get_it.dart';
import 'package:secure_chat/store/auth/auth_state.dart';

void registerStoreGetIt() {
  GetIt.I.registerSingleton(AuthState());
}
