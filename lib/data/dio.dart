import 'dart:io';

import 'package:dio/dio.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';

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
      final token = await SharedPreferenceHelper.getAuthToken();

      if (token != null && token.isNotEmpty) {
        options.headers
            .putIfAbsent(HttpHeaders.authorizationHeader, () => token);
      }
    })
  ]);
