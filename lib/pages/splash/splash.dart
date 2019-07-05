import 'package:flutter/material.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/store/auth/auth_store.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authRepository = getIt<AuthRepository>();
  final authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Image.asset('assets/icons/ic_appicon.png')),
    );
  }

  getAuthUser() async {
    final token = await SharedPreferenceHelper.getAuthToken();

    if (token != null && token.isNotEmpty) {
      final authUser = await authRepository.getCurrentUser();
      authStore.setCurrentUser(authUser);
    }
    await navigate();
  }

  navigate() async {
    bool isLoggedIn = await SharedPreferenceHelper.isLoggedIn();

    Navigator.of(context)
        .pushReplacementNamed(isLoggedIn ? Routes.rooms : Routes.login);
  }
}
