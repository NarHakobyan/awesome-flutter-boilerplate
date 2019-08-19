import 'package:get_it/get_it.dart';
import 'package:secure_chat/store/auth/auth_store.dart';

void registerStoreGetIt() {
  GetIt.I.registerSingleton(AuthStore());
}
