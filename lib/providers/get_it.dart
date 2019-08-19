import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/data/datasources/post/post_datasource.dart';
import 'package:secure_chat/data/dio.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/providers/application_provider.dart';
import 'package:secure_chat/routes.dart';

void registerGetIt() {
  GetIt.I.registerSingleton(dio);

  GetIt.I.registerLazySingleton<Router>(() {
    final router = Router();
    Routes.configureRoutes(router);

    return router;
  });

  GetIt.I.registerSingleton(ApplicationProvider());
  GetIt.I.registerSingleton(AppDatabase());

  // Repositories
  GetIt.I.registerSingleton(PostDataSource());
  GetIt.I.registerSingleton(PostRepository());
  GetIt.I.registerSingleton(AuthRepository());
}
