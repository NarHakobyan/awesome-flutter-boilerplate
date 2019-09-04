import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const String authToken = 'authToken';
}

class SharedPreferenceHelper {
  // General Methods: ----------------------------------------------------------
  static Future<String> getAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Preferences.authToken);
  }

  static Future<void> setAuthToken(String authToken) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(Preferences.authToken, authToken);
  }

  static Future<void> removeAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(Preferences.authToken);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Preferences.authToken) ?? false;
  }

  static Future<Brightness> getBrightness() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getBool('isDark') ?? false)
        ? Brightness.dark
        : Brightness.light;
  }
}
