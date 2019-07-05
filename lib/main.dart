import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_chat/app.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/store/store.dart';

void main() async {
  registerGetIt();
  registerStoreGetIt();

  final brightness = await SharedPreferenceHelper.getBrightness();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(MyApp(
    brightness: brightness,
  ));
}
