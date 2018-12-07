import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class AppComponent extends StatefulWidget {
  @override
  AppComponentState createState() => AppComponentState();
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Secure chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
