import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/routes.dart';

import 'config/application.dart';
import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'pages/splash/splash.dart';

final application = getIt<Application>();

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    registerGetIt();
    final router = new Router();
    Routes.configureRoutes(router);
    application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      onGenerateRoute: application.router.generator,
      home: SplashScreen(),
    );
  }
}
