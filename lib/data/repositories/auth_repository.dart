import 'dart:async';

import 'package:dio/dio.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/providers/get_it.dart';

class AuthRepository {
  final _dioClient = getIt<Dio>();

  Future<User> getCurrentUser() {
    return _dioClient
        .get<dynamic>('/auth/me')
        .then((res) => User.fromJson(res.data));
  }

  Future<User> registerUser(Map<String, dynamic> data) {
    return _dioClient
        .post('/auth/register', data: data)
        .then((res) => User.fromJson(res.data));
  }
}
