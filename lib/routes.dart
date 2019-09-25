import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/pages/chat/chat_page.dart';
import 'package:secure_chat/pages/login/login_page.dart';
import 'package:secure_chat/pages/register/register_page.dart';
import 'package:secure_chat/pages/rooms/rooms_page.dart';

class Routes {
  static final Router I = GetIt.I<Router>();

  static String login = '/login';
  static String register = '/register';
  static String rooms = '/rooms';
  static String singleRoom = '/rooms/:id';

  static void configureRoutes(Router router) {
    router
      ..notFoundHandler = Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return const Scaffold(
          body: Center(
            child: Text('Not found'),
          ),
        );
      })
      ..define(login, handler: Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return LoginPage();
      }))
      ..define(register, handler: Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return RegisterPage();
      }))
      ..define(rooms, handler: Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return RoomsPage();
      }))
      ..define(singleRoom, handler: Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return ChatPage(
          roomId: params['id'][0],
        );
      }))
      ..printTree();
  }
}
