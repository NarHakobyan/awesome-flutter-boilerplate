import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/flavor_mode.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/data/datasources/post/post_datasource.dart';
import 'package:secure_chat/data/dio.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/routes.dart';

import 'flavor.dart';

void registerGetIt(FlavorMode flavorMode) {
  GetIt.I.registerSingleton<Dio>(dio);

  GetIt.I.registerLazySingleton<Router>(() {
    final Router router = Router();
    Routes.configureRoutes(router);

    return router;
  });

  GetIt.I.registerLazySingleton<Flavor>(() => Flavor(mode: flavorMode));

  GetIt.I.registerSingleton<AppDatabase>(AppDatabase());

  // Repositories
  GetIt.I.registerSingleton<PostDataSource>(PostDataSource());
  GetIt.I.registerSingleton<PostRepository>(PostRepository());
  GetIt.I.registerSingleton<AuthRepository>(AuthRepository());
}
