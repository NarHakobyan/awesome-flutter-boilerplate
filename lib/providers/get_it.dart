import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/constants/preferences.dart';
import 'package:secure_chat/data/app_database.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = new GetIt();

void registerGetIt() {
  getIt.registerLazySingleton<Dio>(() {
    final options = BaseOptions(
      baseUrl: "http://localhost:3000",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    final Dio dio = Dio(options)
      ..interceptors.addAll([
        LogInterceptor(responseBody: true, error: true),
        InterceptorsWrapper(onRequest: (RequestOptions options) async {
          // getting shared pref instance
          var prefs = await SharedPreferences.getInstance();

          // getting token
          var token = prefs.getString(Preferences.auth_token);

          if (token != null && token.isNotEmpty) {
            options.headers
                .putIfAbsent(HttpHeaders.authorizationHeader, () => token);
          } else {
            print('Auth token is null');
          }
        })
      ]);

    return dio;
  });

  getIt.registerLazySingleton<Router>(() {
    final router = Router();
    Routes.configureRoutes(router);

    return router;
  });

  getIt.registerSingleton(Application());
  getIt.registerSingleton(AppDatabase());

  // Repositories
  getIt.registerSingleton(PostRepository());
  getIt.registerSingleton(AuthRepository());
}
