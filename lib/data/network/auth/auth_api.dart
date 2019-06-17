import 'dart:async';

import 'package:dio/dio.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/providers/get_it.dart';

class AuthApi {
  final _dioClient = getIt<Dio>();

  Future<User> getCurrentUser() {
    return _dioClient
        .get<dynamic>('/auth/me')
        .then((res) => User.fromJson(res.data));
  }
}
