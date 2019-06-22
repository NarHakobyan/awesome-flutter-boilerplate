import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/store/auth/auth_store.dart';

void registerStoreGetIt() {
  getIt.registerSingleton(AuthStore());
}
