import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/providers/get_it.dart' show getIt, registerGetIt;
import 'package:secure_chat/routes.dart';

final application = getIt<Application>();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    registerGetIt();
    final router = Router();
    Routes.configureRoutes(router);
    application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Secure chat',
      theme:
          ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'ProximaNova'),
      onGenerateRoute: application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
