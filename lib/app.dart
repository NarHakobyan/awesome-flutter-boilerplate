import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/constants/strings.dart';
import 'package:secure_chat/pages/splash/splash.dart';

import 'generated/i18n.dart';

class MyApp extends StatelessWidget {
  MyApp({ this.brightness });

  final Router router = GetIt.I<Router>();
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: brightness,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      themedWidgetBuilder: (BuildContext context, ThemeData theme) => MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate
        ],
        localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en')),
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: true,
        title: Strings.appName,
        theme: theme,
        onGenerateRoute: router.generator,
        home: SplashScreen(),
      ),
    );
  }
}
