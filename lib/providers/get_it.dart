import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/data/datasources/post/post_datasource.dart';
import 'package:secure_chat/data/dio.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/providers/application_provider.dart';
import 'package:secure_chat/routes.dart';

GetIt getIt = GetIt();

void registerGetIt() {
  getIt.registerSingleton(dio);

  getIt.registerLazySingleton<Router>(() {
    final router = Router();
    Routes.configureRoutes(router);

    return router;
  });

  getIt.registerSingleton(ApplicationProvider());
  getIt.registerSingleton(AppDatabase());

  // Repositories
  getIt.registerSingleton(PostDataSource());
  getIt.registerSingleton(PostRepository());
  getIt.registerSingleton(AuthRepository());
}
