import 'dart:io';

import 'package:dio/dio.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';

final BaseOptions options = BaseOptions(
  baseUrl: 'http://localhost:3000',
  connectTimeout: 5000,
  receiveTimeout: 3000,
  headers: <String, dynamic>{'Content-Type': 'application/json; charset=utf-8'},
);

final Dio dio = Dio(options)
  ..interceptors.addAll(<Interceptor>[
    LogInterceptor(responseBody: true, error: true),
    InterceptorsWrapper(onRequest: (RequestOptions options) async {
      final String token = await SharedPreferenceHelper.getAuthToken();

      if (token != null && token.isNotEmpty) {
        options.headers
            .putIfAbsent(HttpHeaders.authorizationHeader, () => token);
      }
    })
  ]);
