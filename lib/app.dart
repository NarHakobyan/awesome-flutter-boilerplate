import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/strings.dart';
import 'package:secure_chat/pages/splash/splash.dart';

class MyApp extends StatelessWidget {
  final router = GetIt.I<Router>();
  final Brightness brightness;


  MyApp({this.brightness});

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: brightness,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: true,
        title: Strings.appName,
        theme: theme,
        onGenerateRoute: router.generator,
        home: SplashScreen(),
      ),
    );
  }
}
