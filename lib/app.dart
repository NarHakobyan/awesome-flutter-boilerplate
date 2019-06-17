import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/constants/strings.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/pages/splash/splash.dart';
import 'package:secure_chat/providers/get_it.dart' show getIt, registerGetIt;

class MyApp extends StatefulWidget {
  final Brightness brightness;

  @override
  _MyAppState createState() => _MyAppState();

  MyApp({@required this.brightness});
}

class _MyAppState extends State<MyApp> {
  final router = getIt<Router>();
  final sharedPreferenceHelper = getIt<SharedPreferenceHelper>();

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: widget.brightness,
      data: (brightness) => new ThemeData(
            primarySwatch: Colors.blue,
            brightness: brightness,
          ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: theme,
          onGenerateRoute: router.generator,
          home: SplashScreen(),
        );
      },
    );
  }
}