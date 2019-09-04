import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/models/user/user.dart';

class AuthRepository {
  final Dio _dioClient = GetIt.I<Dio>();

  Future<User> getCurrentUser() {
    return _dioClient
        .get<dynamic>('/auth/me')
        .then((Response<dynamic> res) => User.fromJson(res.data));
  }

  Future<User> registerUser(Map<String, dynamic> data) {
    return _dioClient
        .post('/auth/register', data: data)
        .then((Response<dynamic> res) => User.fromJson(res.data));
  }
}
