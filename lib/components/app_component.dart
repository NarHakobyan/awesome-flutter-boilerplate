import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class AppComponent extends StatefulWidget {
  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  _AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Secure chat',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'ProximaNova'),
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
