import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:secure_chat/constants/preferences.dart';

class SharedPreferenceHelper {
  // General Methods: ----------------------------------------------------------
  static Future<String> getAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Preferences.auth_token);
  }

  static Future<void> saveAuthToken(String authToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Preferences.auth_token, authToken);
  }

  static Future<void> removeAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(Preferences.auth_token);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Preferences.auth_token) ?? false;
  }

  static Future<Brightness> getBrightness() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getBool("isDark") ?? false)
        ? Brightness.dark
        : Brightness.light;
  }
}
