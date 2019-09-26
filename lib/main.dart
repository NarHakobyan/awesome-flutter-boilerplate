import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:secure_chat/app.dart';
import 'package:secure_chat/constants/flavor_mode.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/providers/get_it.dart';

import 'generated/i18n.dart';

Future<void> run({FlavorMode flavor = FlavorMode.development}) async {
  if (flavor == FlavorMode.development) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print(
          '[${rec.level.name}] (${DateFormat('HH:mm:ss').format(rec.time)}) ${rec.loggerName}: ${rec.message}');
    });
  }
  WidgetsFlutterBinding.ensureInitialized();
  registerGetIt(flavor);

  await S.delegate.load(const Locale('en'));

  final brightness = await SharedPreferenceHelper.getBrightness();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(
    MyApp(
      brightness: brightness,
    ),
  );
}

Future<void> main() async {
  await run();
}
