import 'dart:async';

import 'package:flutter/material.dart';
import 'package:secure_chat/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Image.asset('assets/icons/ic_appicon.png')),
    );
  }

  startTimer() {
    return Timer(Duration(milliseconds: 5000), navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.rooms);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
