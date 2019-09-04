import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/data/repositories/auth_repository.dart';
import 'package:secure_chat/helpers/shared_preference_helper.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/store/auth/auth_store.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository authRepository = GetIt.I<AuthRepository>();
  final AuthStore authStore = GetIt.I<AuthStore>();

  @override
  void initState() {
    super.initState();
    getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Image.asset('assets/icons/ic_appicon.png'),
      ),
    );
  }

  Future<void> getAuthUser() async {
    final String token = await SharedPreferenceHelper.getAuthToken();

    if (token != null && token.isNotEmpty) {
      final User authUser = await authRepository.getCurrentUser();
      authStore.setCurrentUser(authUser);
    }
    await navigate();
  }

  Future<void> navigate() async {
    final bool isLoggedIn = await SharedPreferenceHelper.isLoggedIn();

    await Navigator.of(context)
        .pushReplacementNamed(isLoggedIn ? Routes.rooms : Routes.login);
  }
}
