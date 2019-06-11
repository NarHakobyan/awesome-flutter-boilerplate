import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/constants/preferences.dart';
import 'package:secure_chat/data/local/app_database.dart';
import 'package:secure_chat/data/local/datasources/post/post_datasource.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/store/auth/auth_store.dart';
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

          if (token != null) {
            options.headers.putIfAbsent('Authorization', () => token);
          } else {
            print('Auth token is null');
          }
        })
      ]);

    return dio;
  });

  getIt.registerSingleton(Application());
  getIt.registerSingleton(AppDatabase());
  getIt.registerSingleton(SharedPreferenceHelper());
  getIt.registerSingleton(PostDataSource());
  getIt.registerSingleton(AuthStore());
}
