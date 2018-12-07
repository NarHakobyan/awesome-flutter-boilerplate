/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 *
 * Copyright (c) 2018 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/pages/chat_page_component.dart';

import 'package:secure_chat/pages/rooms_page_component.dart';

class Routes {
  static String rooms = "/";
//  static String rooms = "/rooms";
  static String singleRoom = "/rooms/:id";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
            return Scaffold(body: Center(child: Text('Not found'),),);
    });

    router.define(rooms, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return RoomsPageComponent();
        }));


    router.define(singleRoom, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return ChatPageComponent(roomId: params['id'][0],);
        }));

    router.printTree();
  }
}
