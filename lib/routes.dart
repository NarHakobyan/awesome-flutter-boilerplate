import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:secure_chat/pages/chat/chat_page.dart';
import 'package:secure_chat/pages/login/login_page.dart';
import 'package:secure_chat/pages/register/register_page.dart';
import 'package:secure_chat/pages/rooms/rooms_page.dart';

class Routes {
  static String login = "/login";
  static String register = "/register";
  static String rooms = "/rooms";
  static String singleRoom = "/rooms/:id";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: Center(
          child: Text('Not found'),
        ),
      );
    });

    router.define(login, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    }));

    router.define(register, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return RegisterPage();
    }));

    router.define(rooms, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return RoomsPage();
    }));

    router.define(singleRoom, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ChatPage(
        roomId: params['id'][0],
      );
    }));

    router.printTree();
  }
}
